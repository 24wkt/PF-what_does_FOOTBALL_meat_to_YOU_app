class Public::BookmarksController < ApplicationController

  def create
    @blog = Blog.find(params[:blog_id])
    bookmark = current_end_user.bookmarks.new(blog_id: @blog.id, end_user_id: current_end_user.id)
    bookmark.save
  end

  def destroy
    @blog = Blog.find(params[:blog_id])
    bookmark = current_end_user.bookmarks.find_by(blog_id: @blog.id, current_end_user_id: current_end_user.id)
    bookmark.destroy
  end

end
