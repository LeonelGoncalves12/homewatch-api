# Serializer for home objects
class StatisticSerializer < ActiveModel::Serializer
  attributes :id, :thingID, :status, :created_at, :scenario, :timed_task, :triggered_task
end
