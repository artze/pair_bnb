class Listing < ApplicationRecord
  belongs_to :user
  validates :title, :description, :price, :address, :home_type, :room_type, :bedroom, :bathroom, :accommodate, presence: true
end
