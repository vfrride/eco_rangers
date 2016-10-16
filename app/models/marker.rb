class Marker < ApplicationRecord
  acts_as_mappable

  belongs_to :ranger
  belongs_to :place
  belongs_to :place_type

  def lat_lng
    [lat, lng]
  end
end
