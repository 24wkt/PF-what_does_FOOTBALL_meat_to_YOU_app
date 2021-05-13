class Admin::EndUsersController < ApplicationController

  def index
    @end_users = EndUser.all
  end

  def show
    @end_user = EndUser.find(params[:id])
    @blogs = @end_user.blogs
  end
end
