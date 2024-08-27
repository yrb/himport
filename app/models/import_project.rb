class ImportProject < ApplicationRecord
  has_many :hilti_imports, dependent: :destroy

  # def inspection_template
  #   @inspection_template ||= InspectionTemplate.from_json(JSON.parse(template))
  # end
end
