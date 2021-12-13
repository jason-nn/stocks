class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user_id
  before_action :check_admin, only: %i[index show new create edit update]
  before_action :check_non_admin, only: %i[account]
  before_action :set_user, only: %i[show edit update]

  def index
    @users = User.where(admin: false).order('created_at DESC')
  end

  def show; end

  def new; end

  def create; end

  def edit; end

  def update; end

  def account
    @balance = Transaction.where(user_id: @user_id).pluck(:amount).sum
    @user = current_user
  end

  private

  def set_user_id
    @user_id = current_user.id
  end

  def set_user
    @user = User.find(params[:id])
  end

  def check_admin
    redirect_to root_path if !current_user.admin
  end

  def check_non_admin
    redirect_to root_path if current_user.admin
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params
      .require(:user)
      .permit(:email, :password, :password_confirmation, :admin, :approved)
      .merge(user_id: @user_id)
  end
end
