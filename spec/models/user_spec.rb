require 'rails_helper'

RSpec.describe User, type: :model do
  it "has the username set correctly" do
    user = User.new username: "Pekka"

    expect(user.username).to eq("Pekka")
  end

  it "is not saved without a password" do 
    user = User.create username: "Pekka"

    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  it "is not saved with too short password" do 
    user = User.create username: "Pekka", password: "moi", password_confirmation: "moi"

    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  it "is not saved with a lowercase only password" do 
    user = User.create username: "Pekka", password: "salasana", password_confirmation: "salasana"

    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  it "is not saved without a password" do 
    user = User.create username: "Pekka"

    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  describe "with a proper password" do
    let(:user){ FactoryBot.create(:user) }
    
    it "is saved" do
      expect(user).to be_valid
      expect(User.count).to eq(1)
    end

    it "and with two ratings, has the correct ratings count" do
      FactoryBot.create(:rating, score: 10, user: user)
      FactoryBot.create(:rating, score: 20, user: user)

      expect(user.ratings.count).to eq(2)
    end
  end

  describe "favorite beer" do
    let(:user){ FactoryBot.create(:user) }

    it "has method for determining the favorite beer" do
      expect(user).to respond_to(:favorite_beer)
    end

    it "without ratings does not have a favorite beer" do
      expect(user.favorite_beer).to eq(nil)
    end

    it "is the only rated if only one rating" do
      beer = FactoryBot.create(:beer)
      rating = FactoryBot.create(:rating, score: 20, beer: beer, user: user)

      expect(user.favorite_beer).to eq(beer)
    end

    it "is the one with highest rating if several rated" do
      create_beers_with_many_ratings({user: user}, 10, 20, 15, 7, 9)
      best = create_beer_with_rating({ user: user }, 25 )

      expect(user.favorite_beer).to eq(best)
    end
  end

  describe "favorite style" do
    let(:user){ FactoryBot.create(:user) }

    it "has method for determining the favorite style" do
      expect(user).to respond_to(:favorite_style)
    end

    it "without ratings does not have a favorite style" do
      expect(user.favorite_style).to eq(nil)
    end

    it "is the only rated if only one rating" do
      beer = FactoryBot.create(:beer)
      rating = FactoryBot.create(:rating, score: 20, beer: beer, user: user)

      expect(user.favorite_style).to eq(beer.style)
    end

    it "is the one with highest average rating if several rated" do
      create_beer_with_rating_and_style({user: user}, 10, "IPA")
      create_beer_with_rating_and_style({user: user}, 15, "Porter")
      create_beer_with_rating_and_style({user: user}, 27, "Lager")
      create_beer_with_rating_and_style({user: user}, 27, "Lager")
      create_beer_with_rating_and_style({user: user}, 27, "Lager")
      create_beer_with_rating_and_style({user: user}, 30, "Porter")

      expect(user.favorite_style).to eq("Lager")
    end
  end

  describe "favorite brewery" do
    let(:user){ FactoryBot.create(:user) }

    it "has method for determining the favorite brewery" do
      expect(user).to respond_to(:favorite_brewery)
    end

    it "without ratings does not have a favorite brewery" do
      expect(user.favorite_brewery).to eq(nil)
    end

    it "is the only rated if only one rating" do
      beer = create_beer_with_rating({user: user}, 20)

      expect(user.favorite_brewery).to eq(beer.brewery)
    end

    it "is the one with highest average rating if several rated" do
      first = FactoryBot.create(:brewery, name: "first")
      second = FactoryBot.create(:brewery, name: "second")
      third = FactoryBot.create(:brewery, name: "third")

      create_beer_with_rating_and_brewery({user: user}, 10, second)
      create_beer_with_rating_and_brewery({user: user}, 15, first)
      create_beer_with_rating_and_brewery({user: user}, 27, third)
      create_beer_with_rating_and_brewery({user: user}, 27, third)
      create_beer_with_rating_and_brewery({user: user}, 27, third)
      create_beer_with_rating_and_brewery({user: user}, 30, first)
      create_beer_with_rating_and_brewery({user: user}, 40, second)

      expect(user.favorite_brewery).to eq(third)
    end
  end
end 

def create_beer_with_rating(object, score)
  beer = FactoryBot.create(:beer)
  FactoryBot.create(:rating, beer: beer, score: score, user: object[:user] )
  beer
end

def create_beers_with_many_ratings(object, *scores)
  scores.each do |score|
    create_beer_with_rating(object, score)
  end
end

def create_beer_with_rating_and_style(object, score, style)
  beer = FactoryBot.create(:beer, style: style)
  FactoryBot.create(:rating, beer: beer, score: score, user: object[:user] )
  beer
end

def create_beer_with_rating_and_brewery(object, score, brewery)
  beer = FactoryBot.create(:beer, brewery: brewery)
  FactoryBot.create(:rating, beer: beer, score: score, user: object[:user] )
  beer
end

