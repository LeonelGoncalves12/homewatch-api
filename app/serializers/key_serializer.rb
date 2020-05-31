# Serializer for key objects
class KeySerializer < ActiveModel::Serializer
  attributes :name, :info
end
