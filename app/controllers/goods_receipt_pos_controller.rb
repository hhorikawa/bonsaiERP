
# author: Boris Barroso
# email: boriscyber@gmail.com

# 購買入庫
class GoodsReceiptPosController < ApplicationController
  before_action :set_store

  before_action :set_inv, only: [:show, :edit, :update, :destroy]

  
  def index
    # TODO: 完了したものは除外するか, フィルタ可能に
    @orders = PurchaseOrder.where(ship_to_id: @store.id)

    @invs = Inventory.where(operation: 'exp_in').page(params[:page])
  end

  
  # GET
  # /expenses_inventory_ins/new?store_id=:store_id&expense_id=:expense_id
  def new
    @order = PurchaseOrder.find params[:po_id]
    
    # form object 
    @inv = Expenses::InventoryIn.new(
      Inventory.new store_id: @store.id, order: @order,
                    date: Date.today,
                    description: "Recoger mercadería egreso PO##{@order.id}"
    )
    @inv.build_details_from_order
  end

  
  # POST /expenses_inventory_ins
  # store_id&expense_id=:expense_id
  def create
    @order = PurchaseOrder.find params[:po_id]
    # wrap
    @inv = Expenses::InventoryIn.new(
                Inventory.new store_id: @store.id, order: @order,
                              creator_id: current_user.id,
                              operation: 'exp_in' )
    @inv.assign inventory_params, params.require(:detail), @store.id

    begin
      ActiveRecord::Base.transaction do
        # atomic save in form object
        @inv.save!
      end
    rescue ActiveRecord::RecordInvalid => e
      render :new, status: :unprocessable_entity
      return
    end
      
    redirect_to({action:"show", id: @inv.model_obj}, notice: 'Se realizó el ingreso de inventario.')
  end


  def show
  end

  def edit
    # wrap
    @inv = Expenses::InventoryIn.new(@inv)
  end

  def update
    # wrap
    @inv = Expenses::InventoryIn.new(@inv)
    @inv.assign inventory_params, params.require(:detail)
    
    # TODO: impl.
  end

  def destroy
    @inv.destroy!
    # TODO: impl.
  end

  
private

  def set_store
    @store = Store.find params[:store_id]
  end

  def set_inv
    @inv = Inventory.where(operation: 'exp_in', id: params[:id]).take
    raise ActiveRecord::RecordNotFound if !@inv
  end

  
  def inventory_params
    # form object
    params.require(:expenses_inventory_in).permit(
        :description, :date, :expense_id,
        inventory_details_attributes: [:item_id, :quantity]
      )
  end
end
