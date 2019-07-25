class CreateVotes < ActiveRecord::Migration[5.2]
  def change
    create_table :votes do |t|
      t.integer :score
      t.references :user, foreign_key: true
      t.references :beer, foreign_key: true
      t.text :description

      t.timestamps
    end
  end
end
