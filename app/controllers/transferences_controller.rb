
# author: Boris Barroso
# email: boriscyber@gmail.com

# 振替伝票, 会計仕訳  -- Comprobantes de transferencia, asientos contables
class TransferencesController < ApplicationController
  before_action :find_account

  # GET /transferences?account_id
  def new
    @transference = Transference.new(account_id: params[:account_id], date: Time.zone.now.to_date)
  end

  def create
    @transference = Transference.new(transference_params)

    if @transference.transfer
      redirect_to @transference.account, notice: 'Se realizo correctamente la transferencia.'
    else
      render 'new'
    end
  end

  private

    def find_account
      @account = Accounts::Query.new.money.where(id: params[:account_id]).first

      unless @account
        redirect_back(fallback_location: root_path, alert: 'Debe seleccionar una cuenta activa')
      end
    end

    def transference_params
      transference_attrs = params.require(:transference).permit(:account_to_id, :amount, :date, :exchange_rate, :reference, :verification)
      transference_attrs[:account_id] = @account.id
      transference_attrs
    end
end
