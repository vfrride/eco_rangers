json.extract! place_type, :id, :name, :description, :img_url, :status, :created_at, :updated_at
json.url place_type_url(place_type, format: :json)