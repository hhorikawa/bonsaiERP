
# author: Boris Barroso
# email: boriscyber@gmail.com

# 自社の銀行口座・現金マスタ
class CashesController < ApplicationController
  before_action :find_bank, only: [:show, :edit, :update, :destroy]

  # GET /banks
  def index
    @banks = Bank.order('name asc')
  end

  # GET /banks/1
  def show
  end

  # GET /banks/new
  def new
    @bank = Bank.new(currency: params[:currency])
  end

  # GET /banks/1/edit
  def edit
  end
  
  # POST /banks
  def create
    @bank = Bank.new(create_bank_params)

    if @bank.save
      redirect_to bank_path(@bank.id), notice: 'La cuenta de banco fue creada.'
    else
      render :new
    end
  end

  # PUT /banks/1
  def update
    if @bank.update(update_bank_params)
      redirect_to @bank, notice: 'Se actualizo  correctamente la cuenta de banco.'
    else
      render action: 'edit'
    end
  end

  # Presents money accounts json method
  # GET /banks/money
  def money
    render json: Account.active.money.where(currency: current_organisation.currency)
      .to_json(only: [:id, :currency, :name, :type])
  end

  # DELETE /banks/1
  # DELETE /banks/1.xml
  def destroy
    @bank.destroy
    respond_ajax @bank
  end

  
private

  def find_bank
    @bank = Bank.find(params[:id])
  end

    def update_bank_params
      params.require(:bank).permit(:name, :number, :active, :address, :phone, :website)
    end

    def create_bank_params
      params.require(:bank).permit(:name, :number, :address, :phone, :website, :currency, :amount)
    end
end
