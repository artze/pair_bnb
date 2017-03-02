class Listing < ApplicationRecord
  belongs_to :user
  has_many :listings_tags
  has_many :tags, through: :listings_tags
  has_many :reservations, dependent: :destroy
  validates :title, :description, :price, :street_address, :postcode, :city, :country, :home_type, :room_type, :bedroom, :bathroom, :accommodate, presence: true
  mount_uploaders :images, ImageUploader

  include PgSearch
  pg_search_scope :search_by_city, against: :city, using: :trigram

	# def self.search(search_query)
	# 	where('LOWER(country) LIKE ?', "%#{search_query.downcase}%")
	# end  
end