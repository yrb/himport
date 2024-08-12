class PdfReport < ApplicationRecord
  ARCHIVE_PATTERN = "*/PDF Reports/*.pdf".freeze
  CONTENT_TYPE = "application/pdf".freeze

  include ArchiveCreation

  belongs_to :hilti_import
  has_one_attached :data
end
