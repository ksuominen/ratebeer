class Beer < ApplicationRecord
  belongs_to :brewery
  has_many :ratings, dependent: :destroy
  has_many :raters, through: :ratings, source: :user

  validates :name, presence: true

  def to_s
    "#{name}, #{brewery.name}"
  end
end
