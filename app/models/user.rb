class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

        has_many :posts, dependent: :destroy
        has_many :favorites, dependent: :destroy
        has_many :comments, dependent: :destroy
        attachment :image, type: :image
        validates :name, presence: true, length: { maximum: 20 }


        def self.guest
          find_or_create_by!(name: 'ゲストログイン', email: 'guest@example.com') do |user|
            user.password = SecureRandom.urlsafe_base64
          end
        end

        def active_for_authentication?
          super && (user_status == false)
        end
end
