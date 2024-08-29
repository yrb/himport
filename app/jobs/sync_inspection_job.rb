class SyncInspectionJob < ApplicationJob
  queue_as :default

  def perform(inspection)
    p = inspection.import_project

    asset_update = RestClient.put(
      p.api_path("inspections/#{inspection.clarinspect_id}").to_s,
      inspection.clarinspect_inspection.to_json,
      {
        content_type: :json,
        accept: :json,
        authorization: p.token,
      }
    )
  end
end
