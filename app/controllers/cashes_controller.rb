
# author: Boris Barroso
# email: boriscyber@gmail.com

# 自社の銀行口座・現金マスタ
class CashesController < ApplicationController
  before_action :set_cash, only: [:show, :edit, :update, :destroy]

  # GET /banks
  def index
    @cashes = Cash.eager_load(:account).order('name asc')
  end

  # GET /banks/1
  def show
  end

  # GET /banks/new
  def new
    @cash = Cash.new(currency: params[:currency])
  end

  # GET /banks/1/edit
  def edit
  end
  
  # POST /banks
  def create
    @cash = Cash.new(create_bank_params)

    if @cash.save
      redirect_to @cash, notice: 'La cuenta de banco fue creada.'
    else
      render :new, status: :unprocessable_entity 
    end
  end

  
  # PUT /banks/1
  def update
    @cash.assign_attributes(update_bank_params)
    if @cash.save
      redirect_to @cash, notice: 'Se actualizo  correctamente la cuenta de banco.'
    else
      render :edit, status: :unprocessable_entity 
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
    @cash.destroy!
    redirect_to cashes_path, status: :see_other,
                notice: "The cash account was successfully destroyed." 
  end

  
private

  def set_cash
    @cash = Cash.find(params[:id])
  end

    def update_bank_params
      params.require(:bank).permit(:name, :number, :active, :address, :phone, :website)
    end

    def create_bank_params
      params.require(:bank).permit(:name, :number, :address, :phone, :website, :currency, :amount)
    end
end
