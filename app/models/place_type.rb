class PlaceType < ApplicationRecord
  has_many :places
  has_many :markers
end
