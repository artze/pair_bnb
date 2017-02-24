class Listing < ApplicationRecord
  belongs_to :user
  has_many :listings_tags
  has_many :tags, through: :listings_tags
  has_many :reservations, dependent: :destroy
  validates :title, :description, :price, :address, :home_type, :room_type, :bedroom, :bathroom, :accommodate, presence: true
  mount_uploaders :images, ImageUploader
end