class CreateStatistics < ActiveRecord::Migration[5.1]
  def change
    create_table :statistics do |t|
      t.string :thing_id
      t.json :status
      t.references :user
	    t.references :delayed_job
      t.timestamps
    end
  end
end