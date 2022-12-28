class User < ApplicationRecord
  has_secure_password
  
  validates :username, uniqueness: true, length: { minimum: 3, maximum: 30 }
  validates :password, length: { minimum: 4 }
  validate :check_password

  def check_password
    upper = password =~ /[A-Z]/
    num = password =~ /[0-9]/
    if !upper || !num
      errors.add(:password, "needs to have at least 1 number and 1 uppercase letter")
    end
  end

  has_many :ratings, dependent: :destroy
  has_many :beers, through: :ratings
end
