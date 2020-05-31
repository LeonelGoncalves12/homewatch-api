class AddTriggeredTaskToStatistics < ActiveRecord::Migration[5.1]
  def change
    add_column :statistics, :triggered_task, :string
  end
end
