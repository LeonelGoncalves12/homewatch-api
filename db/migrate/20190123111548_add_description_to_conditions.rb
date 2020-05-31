class AddDescriptionToConditions < ActiveRecord::Migration[5.1]
  def change
    add_column :conditions, :description, :string
  end
end
