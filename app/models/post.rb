class Post < ApplicationRecord
  belongs_to :user
  belongs_to :genre
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags
  has_many :post_images, dependent: :destroy
  accepts_nested_attributes_for :post_images, allow_destroy: true, reject_if: :all_blank
  validates_associated :post_images
  validates :post_images, presence: true
  validates :title, presence: true, length: { maximum: 20 }
  validates :introduction, presence: true, length: { maximum: 100 }
  validates :genre_id, presence: true

  # userがnilの場合にはnilを返すようにします。&.演算子は、userがnilであった場合には、nilを返し、そうでない場合にはuser.idを取得するようにします。
  def favorited_by?(user)
    favorites.where(user_id: user&.id).exists?
  end

  def save_tag(sent_tags)
    # タグが存在していれば、タグの名前を配列として全て取得
      current_tags = self.tags.pluck(:name) unless self.tags.nil?
      # 現在取得したタグから送られてきたタグを除いてoldtagとする
      old_tags = current_tags - sent_tags
      # 送信されてきたタグから現在存在するタグを除いたタグをnewとする
      new_tags = sent_tags - current_tags

      # 古いタグを消す
      old_tags.each do |old|
        self.tags.delete Tag.find_by(name: old)
      end

      # 新しいタグを保存
      new_tags.each do |new|
        new_post_tag = Tag.find_or_create_by(name: new)
        self.tags << new_post_tag
     end
  end
end
