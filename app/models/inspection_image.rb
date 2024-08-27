class InspectionImage < ApplicationRecord
  ARCHIVE_PATTERN = "**/*.jpg".freeze
  CONTENT_TYPE = "image/jpg".freeze
  before_validation :set_asset_id, unless: :clarinspect_asset_id?

  include ArchiveCreation

  belongs_to :hilti_import
  has_one_attached :data


  def set_asset_id
    self.clarinspect_asset_id = SecureRandom.uuid_v4
  end
end
