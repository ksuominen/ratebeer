require 'rails_helper'

RSpec.describe Beer, type: :model do
  it "is not saved without a name" do 
    brewery = Brewery.new name: "test", year: 2000
    style = FactoryBot.create(:style)
    beer = Beer.create style: style, brewery: brewery

    expect(beer).not_to be_valid
    expect(Beer.count).to eq(0)
  end

  it "is not saved without a style" do 
    brewery = Brewery.new name: "test", year: 2000
    beer = Beer.create name: "testiolut", brewery: brewery

    expect(beer).not_to be_valid
    expect(Beer.count).to eq(0)
  end

  it "is saved with name, style and brewery" do
    brewery = Brewery.new name: "test", year: 2000
    style = FactoryBot.create(:style)
    beer = Beer.create name: "testiolut", style: style, brewery: brewery

    expect(beer).to be_valid
    expect(Beer.count).to eq(1)
  end
end
