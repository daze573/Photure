class PostImage < ApplicationRecord
  belongs_to :post
  attachment :image, type: :image
end
