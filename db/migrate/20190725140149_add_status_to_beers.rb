class AddStatusToBeers < ActiveRecord::Migration[5.2]
  def change
    add_column :beers, :status, :string
  end
end
