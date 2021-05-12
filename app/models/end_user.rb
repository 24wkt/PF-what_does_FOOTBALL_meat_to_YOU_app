class EndUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :blogs, dependent: :destroy
  attachment :profile_image, destroy: false

  # フォローに関する記述（フォローする）
  has_many :active_relationships, class_name: "Relationship", foreign_key: :following_id
  has_many :followings, through: :active_relationships, source: :follower

  # フォローに関する記述（フォローされる）
  has_many :passive_relationships, class_name: "Relationship", foreign_key: :follower_id
  has_many :followers, through: :passive_relationships, source: :following

  # 既にフォローしている人をフォローしないようにするメソッド
  def followed_by?(end_user)
    passive_relationships.find_by(following_id: end_user.id).present?
  end

end