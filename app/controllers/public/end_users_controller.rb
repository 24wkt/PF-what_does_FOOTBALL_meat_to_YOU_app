class Public::EndUsersController < ApplicationController

  before_action :authenticate_end_user!

  def index
    @end_users = EndUser.all
  end

  def show
    @end_user = EndUser.find(params[:id])
    # サイドバーに関する定義
    @current_end_user = current_end_user
    @tags = Tag.all
  end

  def follows
    end_user = EndUser.find(params[:id])
    @end_users = end_user.followings
    # サイドバーに関する定義
    @current_end_user = current_end_user
    @tags = Tag.all
  end

  def followers
    end_user = EndUser.find(params[:id])
    @end_users = end_user.followers
    # サイドバーに関する定義
    @current_end_user = current_end_user
    @tags = Tag.all
  end

  def edit
    @end_user = current_end_user
    # サイドバーの関する定義
    @tags = Tag.all
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
    # サイドバーに関する定義
    @end_user = current_end_user
    @tags = Tag.all
  end

  # 退会処理
  def withdraw
    @end_user = current_end_user
    @end_user.update(is_deleted: true)
    reset_session
    redirect_to root_path
  end

  private
    def end_user_params
      params.require(:end_user).permit(:profile_image, :name, :introduction)
    end

end
