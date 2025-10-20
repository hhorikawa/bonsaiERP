
# author: Boris Barroso
# email: boriscyber@gmail.com

# 出荷/納入
class DeliveriesController < ApplicationController
  before_action :set_store
  
  before_action :set_inv, only: [:show, :edit, :update, :destroy]

  
  def index
    # TODO: 完了したものは除外するか, フィルタ可能に
    @orders = SalesOrder.all
    @invs = Inventory.where(operation: 'inc_out').page(params[:page])
  end

  
  # GET
  # /incomes_inventory_ins/new?store_id=:store_id&income_id=:income_id
  def new
    @inv = Incomes::InventoryOut.new(
      store_id: @store.id, income_id: @income.id, date: Time.zone.now.to_date,
      description: "Entregar mercadería ingreso #{ @income }"
    )
    @inv.build_details
  end

  # POST /incomes_inventory_ins
  # store_id&income_id=:income_id
  def create
    @inv = Incomes::InventoryOut.new({store_id: @store.id, income_id: @income.id}.merge(inventory_params))

    if @inv.create
      redirect_to income_path(@income.id), notice: 'Se realizó la entrega de inventario.'
    else
      @inv.build_details  if @inv.details.empty?
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

  
private

  def set_store
    @store = Store.find params[:store_id]
  end

  def set_inv
    @inv = Inventory.where(operation: 'inc_out', id: params[:id]).take
    raise ActiveRecord::RecordNotFound if !@inv
  end


    def inventory_params
      params.require(:incomes_inventory_out).permit(
        :description, :date, :store_id, :income_id,
        inventory_details_attributes: [:item_id, :quantity]
      )
    end
end
