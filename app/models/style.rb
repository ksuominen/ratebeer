class Style < ApplicationRecord
  has_many :beers

  validates :name, presence: true
  validates :description, presence: true
end
