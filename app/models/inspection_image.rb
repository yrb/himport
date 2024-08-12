class InspectionImage < ApplicationRecord
  belongs_to :hilti_import
  has_one_attached :data
end
