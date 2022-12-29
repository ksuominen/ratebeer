class User < ApplicationRecord
  has_secure_password

  validates :username, uniqueness: true, length: { minimum: 3, maximum: 30 }
  validates :password, length: { minimum: 4 }
  validate :check_password

  def check_password
    upper = password =~ /[A-Z]/
    num = password =~ /[0-9]/
    return unless !upper || !num

    errors.add(:password, "needs to have at least 1 number and 1 uppercase letter")
  end

  has_many :ratings, dependent: :destroy
  has_many :beers, through: :ratings
  has_one :membership, dependent: :destroy
  has_one :beerclub, through: :membership

  def favorite_beer
    return nil if ratings.empty?

    ratings.order(score: :desc).limit(1).first.beer
  end

  def favorite_style
    return nil if ratings.empty?

    return beers.first.style if beers.count == 1

    averages = beers.group(:style).average(:score)
    a = averages.max_by { |x, y| y }
    a[0]
  end
end
