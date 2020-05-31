class AddImageToHomes < ActiveRecord::Migration[5.1]
  def change
    add_column :homes, :address, :string
    add_column :homes, :image, :string
  end
end