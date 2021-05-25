class Public::FrontsController < ApplicationController
  def top
    if current_end_user
      redirect_to end_users_home_path
    end
  end

  def about
  end
end
