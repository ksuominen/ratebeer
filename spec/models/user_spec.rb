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
    let(:user){ User.create username: "Pekka", password: "Secret1", password_confirmation: "Secret1" }
    let(:test_brewery) { Brewery.new name: "test", year: 2000 }
    let(:test_beer) { Beer.create name: "testbeer", style: "teststyle", brewery: test_brewery }

    it "is saved" do
      expect(user).to be_valid
      expect(User.count).to eq(1)
    end

    it "and with two ratings, has the correct ratings count" do
      rating = Rating.new score: 10, beer: test_beer
      rating2 = Rating.new score: 20, beer: test_beer

      user.ratings << rating
      user.ratings << rating2

      expect(user.ratings.count).to eq(2)
    end
  end
end
