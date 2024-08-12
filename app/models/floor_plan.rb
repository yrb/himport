class FloorPlan < ApplicationRecord
  ARCHIVE_PATTERN = "*/Floor Plans/*.pdf".freeze
  CONTENT_TYPE = "application/pdf".freeze

  include ArchiveCreation

  belongs_to :hilti_import
  has_one_attached :data
end
