class UsersController < ApplicationController
  def index
    if current_user.admin
      @users = User.where(admin: false).order('created_at DESC')
    else
      redirect_to root_path
    end
  end
end
