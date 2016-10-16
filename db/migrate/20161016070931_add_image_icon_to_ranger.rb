class AddImageIconToRanger < ActiveRecord::Migration[5.0]
  def change
    add_reference :rangers, :ranger_icon, foreign_key: true
  end
end
