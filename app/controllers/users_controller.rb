class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user_id
  before_action :check_admin, only: %i[index show new create edit update]
  before_action :check_non_admin, only: %i[account]
  before_action :set_user, only: %i[show edit update]
  before_action :set_client, only: %i[portfolio]
  before_action :set_portfolio, only: %i[portfolio]

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

  def portfolio; end

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

  def user_params
    params
      .require(:user)
      .permit(:email, :password, :password_confirmation, :admin, :approved)
      .merge(user_id: @user_id)
  end

  def set_portfolio
    transactions =
      Transaction.where(user_id: @user_id).where.not(action: 'cash in')

    portfolio = {}

    transactions.each do |transaction|
      if portfolio[transaction.stock]
        if transaction.action = 'purchase'
          portfolio[transaction.stock] += transaction.quantity
        elsif transaction.action = 'sale'
          portfolio[transaction.stock] -= transaction.quantity
        end
      else
        if transaction.action = 'purchase'
          portfolio[transaction.stock] = transaction.quantity
        elsif transaction.action = 'sale'
          portfolio[transaction.stock] = -transaction.quantity
        end
      end
    end

    @portfolio = portfolio
  end

  def set_client
    @client =
      IEX::Api::Client.new(
        publishable_token: 'Tsk_006d6aef7d2c42b389a9e6aa87636847',
        secret_token: 'Tpk_d2717c1f6e6e4837a40e8753fd3836be',
        endpoint: 'https://sandbox.iexapis.com/v1',
      )
  end
end
