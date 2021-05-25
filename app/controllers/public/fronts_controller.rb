class Public::FrontsController < ApplicationController
  def top
    if current_end_user
      redirect_to end_users_home_path
    elsif current_admin
      redirect_to admin_top_path
    end
  end

  def about
  end
end
