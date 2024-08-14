class ImportProject < ApplicationRecord


  def inspection_template
    @inspection_template ||= InspectionTemplate.from_json(JSON.parse(template))
  end
end
