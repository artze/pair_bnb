class CreateListingsTags < ActiveRecord::Migration[5.0]
  def change
    create_table :listings_tags do |t|
      t.references :listing, index: true, foreign_key: true
      t.references :tag, index:true, foreign_key: true

      t.timestamps
    end

    add_index :listings_tags, [:listing_id, :tag_id], unique: true
  end
end