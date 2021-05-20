class Comment < ApplicationRecord

  belongs_to :end_user
  belongs_to :blog

  validates :comment, presence: true

end
