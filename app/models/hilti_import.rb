class HiltiImport < ApplicationRecord
  has_one_attached :archive
  has_one :list_report
  has_many :floor_plans, dependent: destroy
  has_many :inspection_images, dependent: destroy
  has_many :pdf_reports, dependent: destroy
  has_many :test_reports, dependent: destroy
end
