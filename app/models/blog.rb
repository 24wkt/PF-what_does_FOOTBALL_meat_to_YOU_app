class Blog < ApplicationRecord

  belongs_to :end_user
  attachment :blog_image, destroy: false

  # いいねに関するリレーション
  has_many :likes, dependent: :destroy

  # コメントに関するリレーション
  has_many :comments, dependent: :destroy

  # ブックマークに関するリレーション
  has_many :bookmarks, dependent: :destroy

  # 既にいいねされているか確認するメソッド
  def liked_by?(end_user)
    likes.where(end_user_id: end_user.id).exists?
  end

  # 既にブックマークに登録しているか確認するメソッド
  def bookmarked_by?(end_user)
    bookmarks.where(end_user_id: end_user.id).exists?
  end

end
