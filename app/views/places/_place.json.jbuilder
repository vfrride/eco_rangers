json.extract! place, :id, :name, :address1, :address2, :city, :zip, :state_code, :country, :lat, :lng, :place_type_id, :created_at, :updated_at
json.url place_url(place, format: :json)
