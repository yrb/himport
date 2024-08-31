class HiltiProject < ApplicationRecord
  belongs_to :hilti_import
  has_many :inspections, dependent: :destroy

  after_save_commit :regenerate_inspections!

  def label
    "#{category_name} - #{project_data.project_name}"
  end

  def project_data
    @project_data ||= hilti_import.projects_data[reference]
  end

  def approval_index
    @approval_index ||= approvals.index_by{|v| v["id"] }
  end

  def product_index
    @product_index ||= products.index_by{|v| v["id"] }
  end

  def field_index
    @field_index ||= fields.index_by{ |f| f["name"].downcase }
  end

  def configuration_object
    JSON.parse(configuration_string, object_class: OpenStruct)
  end

  def configuration_string
    JSON.pretty_generate(configuration)
  end

  def configuration_string=(value)
    self.configuration = JSON.parse(value)
  end

  def regenerate_inspections!
    inspections.find_in_batches do |group|
      group.each do |inspection|
        inspection.save!
      rescue StandardError
        Rails.logger.warn("Failed to regenerate inspection #{inspection.id}")
      end
    end
  end

  def build_from_document(doc)
    self.reference = doc.attribute("projectId").to_s
    self.category_id = doc.xpath("categoryId/text()").to_s
    self.category_name = doc.xpath("categoryName/text()").to_s
    self.name = doc.xpath("projectName/text()").to_s
    self.address = doc.xpath("address1/text()").to_s
    self.building = doc.xpath("building/text()").to_s

    self.products = doc.xpath("products/product").map do |product|
      {
        id: product.xpath('id/text()').to_s,
        name: product.xpath('name/text()').to_s,
        approvals: product.xpath('approvals/approval').map do |approval|
          {
            id: approval.xpath('id/text()').to_s,
            name: approval.xpath('name/text()').to_s,
            approval_id: approval.xpath('productApprovalId/text()').to_s
          }
        end
      }
    end

    self.approvals = doc.xpath("approvals/approval").map do |approval|
      {
        id: approval.xpath('id/text()').to_s,
        name: approval.xpath('name/text()').to_s
      }
    end

    self.floor_plans = doc.xpath("attachments/attachment").map do |attachment|
      {
        id: attachment.xpath('attachmentId/text()').to_s,
        name: attachment.xpath('fileName/text()').to_s,
        floor: attachment.xpath('floor/text()').to_s
      }
    end

    self.fields = doc.xpath("attributes/attribute").map do |field|
      {
        id: field.xpath('id/text()').to_s,
        name: field.xpath('name/text()').to_s,
        type: field.xpath('type/text()').to_s,
        values: field.xpath('values/text()').map do |value|
          {
            value: value.to_s
          }
        end
      }
    end
  end
end
