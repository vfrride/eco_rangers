class CreatePlaceTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :place_types do |t|
      t.string :name
      t.string :description
      t.string :img_url
      t.boolean :status

      t.timestamps
    end
  end
end
