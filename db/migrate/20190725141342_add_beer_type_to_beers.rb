class AddBeerTypesToBeers < ActiveRecord::Migration[5.2]
  def change
    add_reference :beers, :beer_types, foreign_key: true
  end
end
