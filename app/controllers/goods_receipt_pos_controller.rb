
# author: Boris Barroso
# email: boriscyber@gmail.com

# 購買入庫
class GoodsReceiptPosController < ApplicationController
  before_action :set_store

  before_action :set_order, only: [:show, :edit, :update, :destroy]

  
  def index
    # TODO: 完了したものは除外するか, フィルタ可能に
    @orders = PurchaseOrder.where(ship_to_id: @store.id)
  end
  
  # GET
  # /expenses_inventory_ins/new?store_id=:store_id&expense_id=:expense_id
  def new
    @inv = Expenses::InventoryIn.new(
      store_id: @store.id, expense_id: @expense.id, date: Date.today,
      description: "Recoger mercadería egreso #{ @expense }"
    )
    @inv.build_details
  end

  
  # POST /expenses_inventory_ins
  # store_id&expense_id=:expense_id
  def create
    @inv = Expenses::InventoryIn.new({store_id: @store.id, expense_id: @expense.id}.merge(inventory_params))

    if @inv.create
      redirect_to expense_path(@expense.id), notice: 'Se realizó el ingreso de inventario.'
    else
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

  def set_order
    @order = PurchaseOrder.find params[:id]
  end

  
    def inventory_params
      params.require(:expenses_inventory_in).permit(
        :description, :date, :store_id, :expense_id,
        inventory_details_attributes: [:item_id, :quantity]
      )
    end
end
