class Beer < ApplicationRecord
  belongs_to :brewery
  has_many :ratings, dependent: :destroy
  has_many :raters, through: :ratings, source: :user
  belongs_to :style

  validates :name, presence: true

  def to_s
    "#{name}, #{brewery.name}"
  end
end
