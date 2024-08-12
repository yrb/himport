class InspectionImage < ApplicationRecord
  ARCHIVE_PATTERN = "*/Inspection Images/*.jpg".freeze
  CONTENT_TYPE = "image/jpg".freeze

  include ArchiveCreation

  belongs_to :hilti_import
  has_one_attached :data
end
