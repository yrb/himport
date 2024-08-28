class HiltiImport < ApplicationRecord
  belongs_to :import_project
  has_one_attached :archive
  has_many :floor_plans, dependent: :destroy
  has_many :inspection_images, dependent: :destroy
  has_many :test_reports, dependent: :destroy
  has_many :hilti_projects, dependent: :destroy
  has_many :inspections, dependent: :destroy

  after_create_commit :start_processing

  Project = Data.define(:id, :project_name, :building, :address, :client_name, :levels, :level_values)
  Level = Data.define(:id, :priority, :name)
  LevelValue = Data.define(:id, :hierarchy_id, :parent_id, :value)

  def projects_data
    @projects_data ||= extract_projects_data
  end

  def extract_projects_data
    doc = Nokogiri::XML(projects)

    # Treat the project with the the building node as the primary
    # for metadata
    doc.xpath('//project/building').map do |address_node|
      extract_project_data(address_node.parent)
    end.index_by { |v| v.id }
  end

  def extract_project_data(project)
    level_values = project.xpath('//hierarchyValue').map do |value|
      LevelValue[
        id: value.xpath('id').text,
        hierarchy_id: value.xpath('hierarchyId').text,
        parent_id: value.xpath('parentId').text,
        value: value.xpath('value').text
      ]
    end.index_by { |v| v.id }

    levels = project.xpath('hierarchies/hierarchy').map do |hierarchy|
      Level[
        hierarchy.xpath('id').text,
        hierarchy.xpath('priority').text,
        hierarchy.xpath('name').text
      ]
    end.index_by { |v| v.id }

    Project.new(
      id: project.xpath('projectId').text,
      project_name: project.xpath('projectName').text,
      building: project.xpath('building').text,
      address: project.xpath('address1').text,
      client_name: project.xpath('clientName').text,
      levels: levels,
      level_values: level_values
    )
  end

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
