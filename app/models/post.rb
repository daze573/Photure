class Post < ApplicationRecord
  attachment :image, type: :image
  belongs_to :user
  belongs_to :genre
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags
  validates :image, presence: true
  validates :title, presence: true, length: { maximum: 100 }
  validates :introduction, presence: true
  validates :genre_id, presence: true

  def favorited?(user)
    favorites.where(user_id: user.id).exists?
  end
end
