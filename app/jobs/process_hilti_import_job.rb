class ProcessHiltiImportJob < ApplicationJob
  queue_as :default

  DATA_PATTERN = '*/*.xml'



  def perform(hilti_import)
    hilti_import.archive.open do |archive|
      Zip::File.open(archive.path) do |zip_file|
        xml_entry = zip_file.glob(DATA_PATTERN).first
        hilti_import.project_name = File.basename(xml_entry.name, '.xml')
        hilti_import.project_data = xml_entry.get_input_stream.read

        [ InspectionImage, FloorPlan, PdfReport, TestReport ].each do |klass|
          zip_file.glob(klass::ARCHIVE_PATTERN).each do |entry|
            klass.create_from_archive(hilti_import, entry)
          rescue StandardError => e
            puts entry.name
            puts e.message
          end
        end

        hilti_import.save!
      end
    end
  end
end
