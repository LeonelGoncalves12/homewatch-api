class AddCronToStatistics < ActiveRecord::Migration[5.1]
  def change
    add_column :statistics, :cron, :string
  end
end
