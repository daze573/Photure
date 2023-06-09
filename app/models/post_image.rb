class PostImage < ApplicationRecord
  belongs_to :post
  attachment :image, type: :image
  validates :image, presence: true
end
