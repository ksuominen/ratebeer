class CreateBeerclubs < ActiveRecord::Migration[7.0]
  def change
    create_table :beerclubs do |t|
      t.string :name
      t.string :string
      t.string :founded
      t.string :integer
      t.string :city
      t.string :string

      t.timestamps
    end
  end
end
