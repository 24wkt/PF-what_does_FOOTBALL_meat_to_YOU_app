class Public::EndUsersController < ApplicationController

  def index
    @end_users = EndUser.all
  end

  def show
    @end_user = EndUser.find(params[:id])
    @likes = Like.where(end_user_id: @end_user.id)
    #@bookmarks = @end_user.bookmarks
  end

  def follows
    end_user = EndUser.find(params[:id])
    @end_users = end_user.followings
  end

  def followers
    end_user = EndUser.find(params[:id])
    @end_users = end_user.followers
  end

  def edit
    @end_user = current_end_user
  end

  def update
    @end_user = current_end_user
    if @end_user.update(end_user_params)
      redirect_to end_user_path(current_end_user)
    else
      render :edit
    end
  end

  # 退会確認画面
  def unsubscribe
  end

  # 退会処理
  def withdraw
  end

  private
    def end_user_params
      params.require(:end_user).permit(:profile_image, :name, :introduction)
    end

end
