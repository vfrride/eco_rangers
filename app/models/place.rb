class Place < ApplicationRecord
  acts_as_mappable

  belongs_to :place_type

  def label
    "#{name}<br/>#{address1}<br/>#{city}, #{state_code}"
  end
end
