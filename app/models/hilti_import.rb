class HiltiImport < ApplicationRecord
  belongs_to :import_project
  has_one_attached :archive
  has_many :floor_plans, dependent: :destroy
  has_many :inspection_images, dependent: :destroy
  has_many :test_reports, dependent: :destroy
  has_many :hilti_projects, dependent: :destroy
  has_many :inspections, dependent: :destroy

  after_create_commit :start_processing



  def create_projects
    doc = Nokogiri::XML(projects)

    doc.xpath('//project').each do |project_doc|
      project = HiltiProject.new hilti_import_id: self.id
      project.build_from_document(project_doc)
      project.save!
    end
  end

  def create_inspections
    doc = Nokogiri::XML(penetrations)
    doc.xpath('//penetration').each do |penetration_doc|
      inspection = Inspection.new hilti_import_id: self.id
      inspection.build_from_document(penetration_doc)
      inspection.save!
    end
  end


  def start_processing
    ProcessHiltiImportJob.perform_later(self)
  end
end
