class Place < ApplicationRecord
  acts_as_mappable

  belongs_to :place_type

  def label
    "#{name}<br/>#{address1}<br/>#{city}, #{state_code}"
  end

  def get_json
    {lat: lat, lng: lng, label: label, place_type_id: place_type_id}
  end
end
