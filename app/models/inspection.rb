class Inspection < ApplicationRecord
  belongs_to :hilti_import
  belongs_to :hilti_project
  has_one :import_project, through: :hilti_import

  before_save :set_clarinspect_inspection

  module Value
    def self.text(text)
      {
        "type" => "text",
        "value" => text || ""
      }
    end

    def self.date(date_str)
      date = DateTime.parse(date_str)
      {
        "type" => "date",
        "day" => date.day,
        "month" => date.month,
        "year" => date.year
      }
    rescue StandardError
      nil
    end

    def self.selection(selections)
      selections = Array(selections).map do |value|
        if value.is_a? Hash
          value
        elsif value.is_a? OpenStruct
          value.to_h.stringify_keys
        else
          Value.option(value, value)
        end
      end
      {
        "type" => "selection",
        "selections" => selections
      }
    end

    def self.photo(asset_id, drawing_id: nil, annotations: [])
      {
        "type" => "photo",
        "asset_id" => asset_id,
        "drawing_id" => drawing_id,
        "annotations" => annotations,
        "text_scale" => 6.0
      }
    end

    def self.option(key, value)
      { "key" => key, "value" => value }
    end

    def self.balloon(marker, text, locator: false, template_text: nil)
      {
        "uuid" => SecureRandom.uuid,
        "annotation_type" => "balloon",
        "annotation_data" => {
          "origin" => marker.origin.to_annotation_point,
          "end_point" => marker.end_point.to_annotation_point,
          "text" => text,
          "full_text" => text,
          "template_text" => template_text,
          "locator" => locator,
          "text_color" => "#000000",
          "fill_color" => "#FFFFFF"
        }
      }
    end
  end

  module Mapper
    def self.pen_attribute(config, inspection)
      attribute_id = config.attribute_id

      if attribute_id.blank?
        attribute_id = inspection.hilti_project.field_index[config.attribute.downcase]["id"]
      end

      inspection.doc.xpath(%{//attribute[@attributeId="#{attribute_id}"]/text()}).to_s
    end

    def self.root_attribute(config, inspection)
      inspection.doc.root.attribute(config.attribute).to_s
    end

    def self.project_attribute(config, inspection)
      inspection.hilti_project.project_data.send(config.attribute)
    end

    def self.fixed(config, inspection)
      config.value
    end

    def self.concatenated(config, inspection)
      values = config.mappers.map do |m_config|
        send(m_config.type, m_config, inspection)
      end.reject(&:blank?)

      if config.separator.present?
        values.join(config.separator)
      else
        values
      end
    end

    def self.level_lookup(config, inspection)
      valueId = inspection.doc.root.attribute(config.attribute).to_s
      inspection.hilti_project.project_data.level_values[valueId].value
    end

    def self.attachment(config, inspection)
      reference = if config.category.present?
        inspection.doc.xpath(%(//attachment[@category="#{config.category}"][#{config.index}])).first["id"]
      else
        inspection.doc.xpath(%(//attachment[#{config.index}])).first["id"]
      end
      image = inspection.hilti_import.inspection_images.find_by(reference: reference)
      image.clarinspect_asset_id
    end

    def self.approval(config, inspection)
      approval_id = inspection.doc.root.attribute('approvalId').to_s
      inspection.hilti_project.approval_index[approval_id]["name"]
    end

    def self.product(config, inspection)
      product_id = inspection.doc.root.attribute('productId').to_s
      inspection.hilti_project.product_index[product_id]["name"]
    end

    def self.additional_products(config, inspection)
      inspection.doc.xpath('//additionalProduct/text()').map(&:to_s).join(config.separator)
    end

    def self.value_map(config, inspection)
      value = send(config.value_mapper.type, config.value_mapper, inspection)
      option = config.options.detect { |option| option[0] == value }
      option[1]
    end
  end

  class InspectionData
    def initialize
      @data = {}
    end

    def add(reference, value)
      @data[reference] = value if value.present?
    end

    def to_hash
      @data
    end
  end

  Marker = Data.define(:origin, :end_point)
  Point = Data.define(:x, :y) do
    def -@
      Point[-self.x, -self.y]
    end

    def -(other)
      Point[self.x - other.x, self.y - other.y]
    end

    def +(other)
      Point[self.x + other.x, self.y + other.y]
    end

    def scale(sX, sY)
      Point[self.x * sX, self.y * sY]
    end

    def flip_y
      Point[self.x, 1.0 - self.y]
    end

    def to_annotation_point
      { "x" => self.x.to_fs(:rounded, precision: 6), "y" => self.y.to_fs(:rounded, precision: 6) }
    end
  end

  def floor_plan
    @floor_plan ||= if marker.present?
                      hilti_import.floor_plans.find_by reference: self.marker["attachment_id"]
                    end
  end

  def number
    doc.root.attribute("itemLabel")
  end

  def doc
    @doc ||= Nokogiri::XML(penetration)
  end

  def marker_location
    @marker_location ||= if floor_plan
                           page = floor_plan.page
                           b = Point[page.bx, page.by]
                           t = Point[page.tx, page.ty]
                           s = t - b

                           rl = raw_location
                           ro = Point[rl[0], rl[1]]
                           re = Point[rl[2], rl[3]]

                           origin = (ro - b).scale(1.0 / s.x, 1.0 / s.y).flip_y
                           end_point = (re - b).scale(1.0 / s.x, 1.0 / s.y).flip_y

                           Marker[
                             origin:,
                             end_point:,
                           ]
                         end
  end

  def images
    doc.xpath("//attachment").map do |attachment|
      reference = attachment.attribute("id").to_s
      OpenStruct.new(
        data: attachment["category"].to_s,
        image: hilti_import.inspection_images.find_by(reference: reference)
      )
    end
  end

  def raw_location
    marker["location"].split(",").map(&:to_f)
  end

  def site_plan_value
    text = doc.root["itemLabel"]&.to_s || ""

    Value.photo(
      floor_plan.clarinspect_asset_id,
      drawing_id: floor_plan.clarinspect_drawing_id,
      annotations: [
        Value.balloon(marker_location, text, locator: true, template_text: configuration.site_plan_template_text)
      ]
    )
  rescue StandardError
    nil
  end

  def configuration
    hilti_project.configuration_object
  end

  def set_clarinspect_inspection
    self.clarinspect_inspection = build_clarinspect_inspection
  end

  def build_clarinspect_inspection
    data = InspectionData.new
    begin
      data.add(configuration.site_plan_field, site_plan_value)

    configuration.mapping.to_h.each do |reference, mapping|
      data.add(
        reference.to_s,
        Value.send(mapping.value_type, Mapper.send(mapping.type, mapping, self))
      )
    rescue StandardError
      nil
    end

    {
      "id" => clarinspect_id,
      "assessment_template_id" => configuration.template_id,
      "work_package_id" => configuration.work_package_id,
      "organisation_id" => import_project.organisation_id,
      "data" => data.to_hash
    }
    rescue StandardError
      {}
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
        "label": marking_node.attribute("itemLabel").to_s,
        "location": marking_node.text
      }
    end
  end


  def sync
    SyncInspectionJob.perform_later(self)
  end
end
