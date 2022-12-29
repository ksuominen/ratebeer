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
  
    it "has method for determining one" do
      expect(user).to respond_to(:favorite_beer)
    end
  
    it "without ratings does not have one" do
      expect(user.favorite_beer).to eq(nil)
    end

    it "is the only rated if only one rating" do
      beer = FactoryBot.create(:beer)
      rating = FactoryBot.create(:rating, score: 20, beer: beer, user: user)
    
      expect(user.favorite_beer).to eq(beer)
    end

    it "is the one with highest rating if several rated" do
      beer1 = FactoryBot.create(:beer)
      beer2 = FactoryBot.create(:beer)
      beer3 = FactoryBot.create(:beer)
      rating1 = FactoryBot.create(:rating, score: 20, beer: beer1, user: user)
      rating2 = FactoryBot.create(:rating, score: 25, beer: beer2, user: user)
      rating3 = FactoryBot.create(:rating, score: 9, beer: beer3, user: user)
    
      expect(user.favorite_beer).to eq(beer2)
    end
  end
end
