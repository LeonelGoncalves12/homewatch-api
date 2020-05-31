class Key < ApplicationRecord

  validates :name, :info, presence: true
end