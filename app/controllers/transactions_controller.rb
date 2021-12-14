class TransactionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user_id
  before_action :check_non_admin, only: %i[cashin cashin_post]

  def index
    if current_user.admin
      @transactions = Transaction.all.order('created_at DESC')
    else
      @transactions =
        Transaction.where(user_id: @user_id).order('created_at DESC')
    end
  end

  def cashin
    @transaction = Transaction.new
  end

  def cashin_post
    @transaction = Transaction.new(cashin_params)

    if @transaction.save
      redirect_to account_path,
                  notice:
                    'Successfully added ' +
                      view_context.number_to_currency(@transaction.amount)
    else
      redirect_to cashin_path, alert: 'Invalid amount.'
    end
  end

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

  def cashin_params
    params
      .require(:transaction)
      .permit(:amount, :action, :stock, :quantity)
      .merge(user_id: @user_id, action: 'cash in')
  end
end
