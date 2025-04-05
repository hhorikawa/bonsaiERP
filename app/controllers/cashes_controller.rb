# encoding: utf-8
# author: Boris Barroso
# email: boriscyber@gmail.com
class CashesController < ApplicationController
  before_action :set_cash, only: [:show, :edit, :update, :destroy]

  include Controllers::Money

  # GET /cashs
  def index
    @cashes = present Cash.order('name asc'), MoneyAccountPresenter
  end

  # GET /cashs/1
  def show
    respond_to do |format|
      format.html
      format.json { render json: @cash }
    end
  end

  # GET /cashs/new
  def new
    @cash = Cash.new
    respond_to do |format|
      format.html
      format.json { render json: @cash }
    end
  end

  # GET /cashs/1/edit

  # POST /cashs
  def create
    @cash = Cash.new(cash_params)

    respond_to do |format|
      if @cash.save
        format.html { redirect_to(cash_path(@cash), notice: 'La cuenta efectivo fue creada.') }
      else
        format.html { render :new }
      end
    end
  end

  # PUT /cashs/1
  def update
    if @cash.update(cash_params)
      flash[:notice] = 'La cuenta efectivo fue actualizada.'
      respond_to do |format|
        format.html { redirect_to @cash }
        format.json { render json: { redirect: url_for(@cash) } }
        format.js { render json: { redirect: url_for(@cash) } }
      end
    else
      render :edit
    end
  end

  # DELETE /cashs/1
  def destroy
    @cash.destroy

    respond_to do |format|
      format.html { redirect_to(cashes_url) }
      format.xml  { head :ok }
    end
  end

  private

    def set_cash
      @cash = present Cash.find(params[:id]), MoneyAccountPresenter
    end

    def cash_params
      params.require(:cash).permit(:name, :currency, :amount, :address, :active)
    end
end
