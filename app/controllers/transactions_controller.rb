class TransactionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user_id
  before_action :check_non_admin, only: %i[cashin]

  def index
    if current_user.admin
      @transactions = Transaction.all.order('created_at DESC')
    else
      @transactions =
        Transaction.where(user_id: @user_id).order('created_at DESC')
    end
  end

  def cashin; end

  private

  def set_user_id
    @user_id = current_user.id
  end

  def check_admin
    redirect_to root_path if !current_user.admin
  end

  def check_non_admin
    redirect_to root_path if current_user.admin
  end
end
