class Listing < ApplicationRecord
  belongs_to :user
  has_many :listings_tags
  has_many :tags, through: :listings_tags
  validates :title, :description, :price, :address, :home_type, :room_type, :bedroom, :bathroom, :accommodate, presence: true
end