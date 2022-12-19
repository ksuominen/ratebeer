class Beer < ApplicationRecord
    belongs_to :brewery
    has_many :ratings

    def average_rating
        sum = 0
        count = 0
        self.ratings.each do |rating|
            count +=1
            sum +=rating.score
        end
        return sum.to_f/count.to_f
    end
end
