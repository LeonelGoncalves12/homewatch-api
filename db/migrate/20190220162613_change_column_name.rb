class ChangeColumnName < ActiveRecord::Migration[5.0]
  def change
    rename_column :statistics, :thing_id, :thingID
  end
end