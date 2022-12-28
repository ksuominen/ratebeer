class Beerclub < ApplicationRecord
    has_many :users, through: :memberships
end
