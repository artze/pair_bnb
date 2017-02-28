class AddImageToListings < ActiveRecord::Migration[5.0]
  def change
    add_column :listings, :image, :text, array: true, default: []
  end
end