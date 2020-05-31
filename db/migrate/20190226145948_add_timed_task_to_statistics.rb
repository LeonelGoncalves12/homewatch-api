class AddTimedTaskToStatistics < ActiveRecord::Migration[5.1]
  def change
    add_column :statistics, :timed_task, :string
    add_column :statistics, :counter, :string
  end
end
