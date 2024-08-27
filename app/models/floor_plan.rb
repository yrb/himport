class FloorPlan < ApplicationRecord
  ARCHIVE_PATTERN = "**/Attachment-*.pdf".freeze
  CONTENT_TYPE = "application/pdf".freeze
  MEDIA_BOX_PATTERN = /MediaBox\[(?<bx>-?\d+\.?\d*)\s+(?<by>-?\d+\.?\d*)\s+(?<tx>-?\d+\.?\d*)\s+(?<ty>-?\d+\.?\d*)\]/


    include ArchiveCreation

  belongs_to :hilti_import
  has_one_attached :data

  def page
    @page ||= OpenStruct.new(metadata["page"])
  end

  def update_page_coordinates!
    self.metadata ||= {}
    self.metadata["page"] = raw_media_box
    save!
  end

  def raw_media_box
    @raw_media_box ||= data.open do |file|
      MEDIA_BOX_PATTERN.match(file.read)&.named_captures&.transform_values(&:to_f)
    end
  end
end
