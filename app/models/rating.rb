class Rating < ApplicationRecord
  belongs_to :beer
  belongs_to :user

  def to_s
    score.to_s
  end
end
