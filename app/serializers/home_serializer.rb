# Serializer for home objects
class HomeSerializer < ActiveModel::Serializer
  attributes :id, :name, :tunnel, :location, :address, :image, :ip_address


  ###adicionado
  has_many :rooms
end
