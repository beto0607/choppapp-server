class CreateProducers < ActiveRecord::Migration[5.2]
  def change
    create_table :producers do |t|
      t.string :name
      t.text :description
      t.string :place
      t.string :status

      t.timestamps
    end
  end
end
