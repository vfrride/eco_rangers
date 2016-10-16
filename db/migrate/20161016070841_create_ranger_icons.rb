class CreateRangerIcons < ActiveRecord::Migration[5.0]
  def change
    create_table :ranger_icons do |t|
      t.string :image_url

      t.timestamps
    end
  end
end
