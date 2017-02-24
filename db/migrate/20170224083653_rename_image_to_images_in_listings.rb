class RenameImageToImagesInListings < ActiveRecord::Migration[5.0]
  def change
  	rename_column :listings, :image, :images
  end
end