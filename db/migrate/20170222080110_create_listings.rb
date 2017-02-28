class CreateListings < ActiveRecord::Migration[5.0]
  def change
    create_table :listings do |t|
      t.string :title
      t.text :description
      t.decimal :price, precision: 10, scale: 2
      t.string :address
      t.string :home_type
      t.string :room_type
      t.integer :bedroom
      t.integer :bathroom
      t.integer :accommodate
      t.references :user, index: true, foreign_key: true

      t.timestamps
    end
  end
end
