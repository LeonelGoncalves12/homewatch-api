class Condition < ApplicationRecord

  belongs_to :user

  validates :city, :wind,  :humidity ,:sunrise, :sunset, :icon, :temperature, :description, presence: true

end