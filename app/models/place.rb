class Place < ApplicationRecord
  acts_as_mappable

  belongs_to :place_type
  has_many :markers
  has_many :rangers, through: :markers


  def label
    lbl = "#{name}"
    lbl += "<br/>#{address1}" if name != address1
    lbl += "<br/>#{city}" if city.present?
    lbl += ", #{state_code}" if state_code.present?
    lbl
  end

  def lat_lng
    [lat, lng]
  end

  def get_json
    {lat: lat, lng: lng, label: label, place_type_id: place_type_id, ranger_ids: ranger_ids}
  end
end
