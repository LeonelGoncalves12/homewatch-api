class RemoveFavoriteOnRooms < ActiveRecord::Migration[5.1]
  def change
    remove_column :rooms, :favorite
  end
end
