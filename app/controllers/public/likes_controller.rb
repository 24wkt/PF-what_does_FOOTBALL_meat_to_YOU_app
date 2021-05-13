class Public::LikesController < ApplicationController

  def create
    @blog = Blog.find(params[:blog_id])
    like = current_end_user.likes.new(blog_id: @blog.id)
    like.save
  end

  def destroy
    @blog = Blog.find(params[:blog_id])
    like = current_end_user.likes.find_by(blog_id: @blog.id)
    like.destroy
  end

end
