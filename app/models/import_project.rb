class ImportProject < ApplicationRecord
  has_many :hilti_imports, dependent: :destroy

  # def inspection_template
  #   @inspection_template ||= InspectionTemplate.from_json(JSON.parse(template))
  # end



  def api_path(path)
    URI::HTTPS.build(host: host, path: "/api/v2/" + path)

  end

  def default_options
    {
      headers: {
      "Authorization" => token,
      "Accept" => "application/json"
      }
    }
  end
end
