class CreateRooms < ActiveRecord::Migration[5.1]
  def change
    create_table :rooms do |t|
      t.string :name
      t.string :favorite
      t.string :owner
      t.string :icon

      t.references :home
      t.timestamps
  end
  end
end
