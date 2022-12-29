class Brewery < ApplicationRecord
  has_many :beers, dependent: :destroy
  has_many :ratings, through: :beers

  validates :year, numericality: { greater_than_or_equal_to: 1040,
                                   only_integer: true }

  validates :name, presence: true

  validate :year_not_in_the_future

  def year_not_in_the_future
    return unless year > Time.now.year

    errors.add(:year, "can't be in the future")
  end
end
