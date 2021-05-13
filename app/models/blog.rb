class Blog < ApplicationRecord

  belongs_to :end_user
  attachment :blog_image, destroy: false
  has_many :likes

  # 既にいいねされているか確認するメソッド
  def liked_by?(end_user)
    likes.where(end_user_id: end_user.id).exists?
  end

end
