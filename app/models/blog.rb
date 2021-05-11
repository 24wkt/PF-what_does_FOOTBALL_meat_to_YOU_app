class Blog < ApplicationRecord

  belongs_to :end_user, optional: true
  attachment :blog_image, destroy: false

end
