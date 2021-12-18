class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user_id
  before_action :check_admin,
                only: %i[index show new create edit update approve]
  before_action :check_non_admin, only: %i[account]
  before_action :set_user, only: %i[show edit update]
  before_action :set_client, only: %i[portfolio]
  before_action :set_portfolio, only: %i[portfolio]
  before_action :check_approved,
                only: %i[index show new create edit update account portfolio]

  def index
    @users = User.where(admin: false).order('created_at DESC')
  end

  def show; end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to users_path, notice: 'Successfully created new account.'
    else
      redirect_to '/user/new', alert: 'Invalid input.'
    end
  end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user.id), notice: 'User was successfully updated.'
    else
      redirect_to '/user/' + @user.id.to_s + '/edit', alert: 'Invalid input.'
    end
  end

  def account
    @balance = Transaction.where(user_id: @user_id).pluck(:amount).sum
    @user = current_user
  end

  def approve
    @user = User.find(params[:id])
    @user.update(approved: true)
    redirect_to users_path, notice: @user.email + ' has been approved'
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

  def check_approved
    redirect_to restricted_path if !current_user.approved
  end

  def user_params
    params.require(:user).permit(:email, :password, :name)
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
