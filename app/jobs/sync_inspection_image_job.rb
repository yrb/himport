class SyncInspectionImageJob < ApplicationJob
  queue_as :default

  def perform(inspection_image)
    return if inspection_image.synced?

    p = inspection_image.import_project

    token = HTTParty.get(
      p.api_path("assets/#{inspection_image.clarinspect_asset_id}/upload_token"),
      p.default_options.merge(query: { organisation_id: p.organisation_id })
    )

    raise "Failed to get token" if token.blank?

    result = inspection_image.data.open do |file|
      RestClient.post(
        token["url"],
        {
          :multipart => true,
          'utf8' => '✓',
          'key' => token['key'],
          'AWSAccessKeyId' => token['aws_access_key_id'],
          'acl' => token['acl'],
          'success_action_status' => token['success_action_status'],
          'policy' => token['policy'],
          'signature' => token['signature'],
          'Content-Type' => 'image/jpeg',
          'file' => file
        }
      )
    end

    raise('Failed amazon upload') unless result.code == 201

    key = Nokogiri::XML(result.body).xpath('//Key[1]').text

    asset_update = RestClient.put(
      p.api_path("assets/#{inspection_image.clarinspect_asset_id}").to_s,
      {
        "organisation_id" => p.organisation_id,
        "key" => key,
      }.to_json,
      {
        content_type: :json,
        accept: :json,
        authorization: p.token,
      }
    )

    raise('Failed to update hub') unless asset_update.code == 200

    inspection_image.synced = true
    inspection_image.save!
  end
end
