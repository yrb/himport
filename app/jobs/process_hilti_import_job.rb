class ProcessHiltiImportJob < ApplicationJob
  queue_as :default

  DATA_PATTERN = '*/*.xml'
  TEMPLATE_PATH = File.join(Rails.root, "lib", "templates")
  PROJECT_TEMPLATE = File.join(TEMPLATE_PATH, 'projects.xslt')
  PENETRATIONS_TEMPLATE = File.join(TEMPLATE_PATH, 'penetrations.xslt')

  def run_transform(input_path, template_path, output_path)
    output, status = Open3.capture2("xalan -in #{input_path} -xsl #{template_path} -out #{output_path}")
    raise "failed to convert" unless status.success?
  end

  def perform(hilti_import)
    Dir.mktmpdir do |dir|
      hilti_import.archive.open do |archive|
        Zip::File.open(archive.path) do |zip_file|
          xml_entry = zip_file.glob(DATA_PATTERN).first
          manifest_filename = File.join(dir, "manifest.xml")
          projects_filename = File.join(dir, "projects.xml")
          penetrations_filename = File.join(dir, "penetrations.xml")

          File.open(manifest_filename, "wb") do |manifest_file|
            IO.copy_stream(xml_entry.get_input_stream, manifest_file)
          end
          run_transform(manifest_filename, PROJECT_TEMPLATE, projects_filename)
          run_transform(manifest_filename, PENETRATIONS_TEMPLATE, penetrations_filename)

          hilti_import.projects = File.read(projects_filename)
          hilti_import.penetrations = File.read(penetrations_filename)

          [InspectionImage, FloorPlan, TestReport].each do |klass|
            zip_file.glob(klass::ARCHIVE_PATTERN).each do |entry|
              klass.create_from_archive(hilti_import, entry)
            rescue StandardError => e
              puts entry.name
              puts e.message
            end
          end

          hilti_import.processed = true
          hilti_import.save!
        end
      end
    end
  end
end
