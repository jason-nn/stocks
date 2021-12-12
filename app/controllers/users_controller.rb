class UsersController < ApplicationController
  def index
    @users = User.where(admin: false).order('created_at DESC')
  end
end
