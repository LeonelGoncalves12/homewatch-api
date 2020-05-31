# Serializer for room objects
class RoomSerializer < ActiveModel::Serializer
  attributes :id, :name, :owner, :icon, :home

end
