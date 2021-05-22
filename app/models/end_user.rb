class EndUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # 投稿に関するリレーション
  has_many :blogs, dependent: :destroy

  # エンドユーザーのアイコン画像
  attachment :profile_image, destroy: false

  # いいねに関するリレーション
  has_many :likes, dependent: :destroy

  # コメントに関するリレーション
  has_many :comments, dependent: :destroy

  # ブックマークに関するリレーション
  has_many :bookmarks, dependent: :destroy

  # 会員ステータスを適用
  enum is_deleted: {有効: false, 退会: true }

  # フォローに関する記述（フォローする）
  has_many :active_relationships, class_name: "Relationship", foreign_key: :following_id
  has_many :followings, through: :active_relationships, source: :follower

  # フォローに関する記述（フォローされる）
  has_many :passive_relationships, class_name: "Relationship", foreign_key: :follower_id
  has_many :followers, through: :passive_relationships, source: :following

  # バリデーション
  validates :name, length: {maximum: 20, minimum: 2}, uniqueness: true, presence: true
  validates :email, presence: true
  validates :introduction, length: {maximum: 200}

  # 既にフォローしている人をフォローしないようにするメソッド
  def followed_by?(end_user)
    passive_relationships.find_by(following_id: end_user.id).present?
  end

  # 退会ユーザーをログインできなくするメソッド
  def active_for_authentication?
    super && (self.is_deleted == "有効")
  end

end