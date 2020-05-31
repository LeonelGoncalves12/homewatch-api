class AddDisplayToTriggeredTasks < ActiveRecord::Migration[5.1]
  def change
    add_column :triggered_tasks, :display, :string
  end
end
