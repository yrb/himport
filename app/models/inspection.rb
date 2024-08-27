class Inspection < ApplicationRecord
  belongs_to :hilti_import
  belongs_to :hilti_project

  def floor_plan
    if marker.present?
      hilti_import.floor_plans.find_by reference: self.marker["attachment_id"]
    end
  end




  def build_from_document(doc)
    self.penetration = doc.to_s
    self.reference = doc.attribute("id").to_s
    self.project_id = doc.attribute("projectId").to_s
    self.category_id = doc.attribute("categoryId").to_s
    self.hilti_project = hilti_import.hilti_projects.find_by(reference: project_id, category_id: category_id)
    self.clarinspect_id = SecureRandom.uuid

    marking_node = doc.xpath('marking').first
    if marking_node
      self.marker = {
        "id": marking_node.attribute("id").to_s,
        "attachment_id": marking_node.attribute("attachmentId").to_s,
        "location": marking_node.text
      }
    end
  end
end
