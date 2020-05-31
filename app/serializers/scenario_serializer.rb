# Serializer for scenario objects
class ScenarioSerializer < ActiveModel::Serializer
  attributes :id, :name, :icon

  has_many :scenario_things
has_one :home
end
