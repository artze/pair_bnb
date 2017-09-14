class Listing < ApplicationRecord
  belongs_to :user
  has_many :listings_tags, dependent: :destroy
  has_many :tags, through: :listings_tags
  has_many :reservations, dependent: :destroy
  validates :title, :description, :price, :street_address, :postcode, :city, :country, :home_type, :room_type, :bedroom, :bathroom, :accommodate, presence: true
  mount_uploaders :images, ImageUploader

  include PgSearch
  pg_search_scope :search_by_location, 
                  against: {
                    city: 'A',
                    country: 'B'
                    },
                  using: {
                    trigram: {
                      threshold: 0.1
                    }
                  }

  pg_search_scope :search_by_tags,
                  associated_against: {
                    listings_tags: :tag_id
                  }

	def self.search(search_query, tags_arr)
	 # where('LOWER(city) LIKE ?', "#{search_query.downcase}%")
    if tags_arr.nil?
      search_by_location(search_query)
    else
      search_by_location(search_query).search_by_tags(tags_arr.join(' '))
    end
	end

end