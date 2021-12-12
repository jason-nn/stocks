class TransactionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user_id

  def index
    if current_user.admin
      @transactions = Transaction.all
    else
      @transactions = Transaction.where(user_id: @user_id)
    end
  end

  private

  def set_user_id
    @user_id = current_user.id
  end
end
