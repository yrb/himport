class FloorPlan < ApplicationRecord
  ARCHIVE_PATTERN = "**/Attachment-*.pdf".freeze
  CONTENT_TYPE = "application/pdf".freeze
  MEDIA_BOX_PATTERN = /MediaBox\s*\[\s*(?<bx>-?\d+\.?\d*)\s+(?<by>-?\d+\.?\d*)\s+(?<tx>-?\d+\.?\d*)\s+(?<ty>-?\d+\.?\d*)\s*\]/
  ROTATE_PATTERN = %r{/Rotate\s+(?<rotation>-?\d+\.?\d*)}

  include ArchiveCreation

  belongs_to :hilti_import
  has_one_attached :data

  def metadata_string
    self.metadata.to_json
  end

  def metadata_string=(value)
    self.metadata = JSON.parse(value)
  end

  def page
    @page ||= OpenStruct.new(page_metadata)
  end

  def page_metadata
    { "bx" => 0.0, "by" => 0.0, "tx" => 1.0, "ty" => 1.0, "rotation" => 0 }.merge(metadata["page"])
  end

  def update_page_coordinates!
    self.metadata ||= {}
    self.metadata["page"] = raw_page_data
    save!
  end

  def raw_page_data
    @raw_page_data ||= data.open do |file|
      data = file.read
      media_box = MEDIA_BOX_PATTERN.match(data)&.named_captures&.transform_values(&:to_f) || {}
      rotation = ROTATE_PATTERN.match(data)&.named_captures&.transform_values(&:to_f) || { "rotation" => 0.0 }

      media_box.merge(rotation)
    end
  end
end
