class Room < ApplicationRecord

  validates :name, :icon, presence: true

  belongs_to :home
  has_many :things, dependent: :destroy

  has_many :lights, class_name: "Things::Light"
  has_many :locks, class_name: "Things::Lock"
  has_many :thermostats, class_name: "Things::Thermostat"
  has_many :weathers, class_name: "Things::Weather"
  has_many :motion_sensors, class_name: "Things::MotionSensor"
end
