class CreateSettings < ActiveRecord::Migration[5.0]
  def change
    create_table :settings do |t|
      t.string :user_id
      t.string :timed_tasks_not
      t.string :triggered_tasks_not
      t.string :theme
      t.string :language
      t.references :user

      t.timestamps
    end
  end
end
