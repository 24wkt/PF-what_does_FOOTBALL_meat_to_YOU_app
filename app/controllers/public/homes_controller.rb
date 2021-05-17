class Public::HomesController < ApplicationController

  def top
    # 新着ブログに関する記述
    @blogs = Blog.all.order(created_at: :desc)
    @blogs = Blog.limit(5).order(created_at: :desc)
    # サイドバーに関する記述
    @end_user = current_end_user
    @tags = Tag.all
  end

  def about
  end

end
