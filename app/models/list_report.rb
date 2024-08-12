class ListReport < ApplicationRecord
  ARCHIVE_PATTERN = "*/*.xlsx".freeze

  belongs_to :hilti_import
  has_one_attached :data
end
