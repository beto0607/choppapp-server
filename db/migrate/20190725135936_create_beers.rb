class CreateBeers < ActiveRecord::Migration[5.2]
  def change
    create_table :beers do |t|
      t.string :name
      t.float :alcohol
      t.integer :ibu
      t.text :description
      t.references :producer, foreign_key: true

      t.timestamps
    end
  end
end
