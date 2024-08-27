class FloorPlan < ApplicationRecord
  ARCHIVE_PATTERN = "**/Attachment-*.pdf".freeze
  CONTENT_TYPE = "application/pdf".freeze

  include ArchiveCreation

  belongs_to :hilti_import
  has_one_attached :data
end
