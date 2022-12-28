class Brewery < ApplicationRecord
  has_many :beers, dependent: :destroy
  has_many :ratings, through: :beers

  validates :year, numericality: { greater_than_or_equal_to: 1040,
                                    less_than_or_equal_to: 2022,
                                    only_integer: true }
  
  validates :name, presence: true
end
