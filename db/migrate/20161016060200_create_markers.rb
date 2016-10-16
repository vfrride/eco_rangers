class CreateMarkers < ActiveRecord::Migration[5.0]
  def change
    create_table :markers do |t|
      t.references :ranger, foreign_key: true
      t.references :place, foreign_key: true
      t.integer :points
      t.decimal :lat, precision: 10, scale: 6
      t.decimal :lng, precision: 10, scale: 6
      t.references :place_type, foreign_key: true

      t.timestamps
    end
  end
end
