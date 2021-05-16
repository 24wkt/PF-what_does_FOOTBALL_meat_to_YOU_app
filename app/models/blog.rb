class Blog < ApplicationRecord

  belongs_to :end_user
  attachment :blog_image, destroy: false

  # 投稿へのタグ付け機能に関するリレーション
  has_many :tag_maps, dependent: :destroy
  has_many :tags, through: :tag_maps

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

    # 投稿に紐付いたタグを保存するためのメソッド
  def save_tag(sent_tags)
    current_tags = self.tags.pluck(:tag_name) unless self.tags.nil?
    old_tags = current_tags - sent_tags
    new_tags = sent_tags - current_tags

    old_tags.each do |old|
      #self.tag_maps.delete Tag.find_by(tag_name: old)
      old_tag = Tag.find_by(tag_name: old)
      self.tag_maps.find_by(tag_id: old_tag.id).destroy
    end

    new_tags.each do |new|
      new_blog_tag = Tag.find_or_create_by(tag_name: new)
      self.tag_maps.create(tag_id: new_blog_tag.id)
      #self.tag_maps << new_blog_tag
    end
  end

end
