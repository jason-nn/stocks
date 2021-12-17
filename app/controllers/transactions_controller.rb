class TransactionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user_id
  before_action :check_non_admin, only: %i[cashin cashin_post]
  before_action :set_client,
                only: %i[buy purchase purchase_post sell sale sale_post]
  before_action :set_balance, only: %i[purchase_post]

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

  def buy
    # @companies = %w[AAPL ABNB AMZN GOOG GRAB MSFT TSLA UBER]
    @companies = %w[AAPL TSLA]
  end

  def purchase
    @company = params[:company]
    @price = (params[:price].to_s + '.' + params[:format].to_s).to_f
    @transaction = Transaction.new
  end

  def purchase_post
    @price = (params[:price].to_s + '.' + params[:format].to_s).to_f
    @quantity = params[:transaction][:quantity].to_i
    @transaction = Transaction.new(purchase_params)

    @transaction.stock = params[:company]
    @transaction.quantity = @quantity
    @transaction.amount = @price * @quantity * -1

    if @balance + @transaction.amount >= 0
      if @transaction.save
        redirect_to root_path,
                    notice:
                      'Successfully purchased ' + @transaction.quantity.to_s +
                        ' ' + @transaction.stock + ' stock '
      else
        redirect_to '/purchase/' + params[:company] + '/' + @price.to_s,
                    alert: 'Invalid amount.'
      end
    else
      redirect_to '/purchase/' + params[:company] + '/' + @price.to_s,
                  alert: 'Insufficient funds.'
    end
  end

  def sell; end

  def sale; end

  def sale_post; end

  def portfolio; end

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
      .permit(:amount)
      .merge(user_id: @user_id, action: 'cash in')
  end

  def purchase_params
    params
      .require(:transaction)
      .permit(:quantity)
      .merge(user_id: @user_id, action: 'purchase')
  end

  def set_balance
    @balance = Transaction.where(user_id: @user_id).pluck(:amount).sum
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
