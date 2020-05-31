# Serializer for weather objects
class ConditionSerializer < ActiveModel::Serializer
  attributes :id, :city, :temperature, :wind, :humidity, :sunrise, :sunset, :icon,:description, :updated_at
end