class CreateCondition< ActiveRecord::Migration[5.1]
  def change
    create_table :conditions do |t|
      t.string :city, null: false
      t.string :wind, null: false
      t.string :humidity, null: false
      t.string :sunrise, null: false
      t.string :sunset, null: false
      t.string :icon, null: false
      t.references :user

      t.timestamps
    end
  end
end
