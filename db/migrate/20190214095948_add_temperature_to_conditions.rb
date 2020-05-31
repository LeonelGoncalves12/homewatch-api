class AddTemperatureToConditions < ActiveRecord::Migration[5.1]
  def change
    add_column :conditions, :temperature, :string
  end
end
