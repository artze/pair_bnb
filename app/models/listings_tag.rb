class ListingsTag < ApplicationRecord
  belongs_to :listing
  belongs_to :tag

  validates_uniqueness_of :tag_id, scope: :listing_id
end