class Tag < ApplicationRecord
	has_many :listings_tags
	has_many :listings, through: :listings_tags
end