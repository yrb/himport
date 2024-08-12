json.extract! hilti_import, :id, :label, :processed, :sent_at, :archive, :created_at, :updated_at
json.url hilti_import_url(hilti_import, format: :json)
json.archive url_for(hilti_import.archive)
