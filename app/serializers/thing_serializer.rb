# Serializer for thing objects
class ThingSerializer < ActiveModel::Serializer
  attributes :id, :name, :favorite, :type, :subtype, :connection_info, :room

  has_one :room
end
