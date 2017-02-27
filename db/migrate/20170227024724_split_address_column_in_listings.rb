class SplitAddressColumnInListings < ActiveRecord::Migration[5.0]
  def change
  	remove_column :listings, :address, :string
  	add_column :listings, :street_address, :string
  	add_column :listings, :postcode, :string
  	add_column :listings, :city, :string
  	add_column :listings, :country, :string
  end
end