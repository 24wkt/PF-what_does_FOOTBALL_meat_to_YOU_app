class Bookmark < ApplicationRecord

  belongs_to :end_user
  belongs_to :blog

  validates_uniqueness_of :blog_id, scope: :end_user_id

end
