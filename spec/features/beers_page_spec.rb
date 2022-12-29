require 'rails_helper'

describe "Beer" do
    let!(:brewery) { FactoryBot.create :brewery, name: "Koff" }
    let!(:user) { FactoryBot.create :user }

    it "when added without name, is not added to the system" do
      sign_in(username: "Pekka", password: "Foobar1")
      visit new_beer_path
      select('Lager', from: 'beer[style]')
      select('Koff', from: 'beer[brewery_id]')
      
      expect{
        click_button('Create Beer')
      }.to change{Beer.count}.by(0)
      expect(page).to have_content "Name can't be blank"
    end
  
    it "when added with proper name, is added to the system" do
      sign_in(username: "Pekka", password: "Foobar1")
      visit new_beer_path
      fill_in('beer_name', with: 'Karhu')
      select('Lager', from: 'beer[style]')
      select('Koff', from: 'beer[brewery_id]')
    
      expect{
        click_button('Create Beer')
      }.to change{Beer.count}.by(1)
    end
  end