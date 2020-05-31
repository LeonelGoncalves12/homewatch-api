class AddScenarioToStatistics < ActiveRecord::Migration[5.1]
  def change
    add_column :statistics, :scenario, :string
  end
end
