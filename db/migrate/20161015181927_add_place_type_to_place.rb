class AddPlaceTypeToPlace < ActiveRecord::Migration[5.0]
  def change
    add_reference :places, :place_type, foreign_key: true
  end
end
