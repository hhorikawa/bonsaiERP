
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
      Inventory.new store_id: @store.id, order_id: @order.id,
                    date: Date.today,
                    description: "Recoger mercadería egreso PO##{@order.id}")
    # @inv.build_details
  end

  
  # POST /expenses_inventory_ins
  # store_id&expense_id=:expense_id
  def create
    @order = PurchaseOrder.find params[:po_id]
    # wrap
    @inv = Expenses::InventoryIn.new(
                Inventory.new store_id: @store.id, order_id: @order.id,
                              creator_id: current_user.id,
                              operation: 'exp_in' )
    @inv.assign inventory_params, params.require(:detail)

    if !@inv.valid?
      render :new, status: :unprocessable_entity
      return
    end

    begin
      ActiveRecord::Base.transaction do
        @inv.model_obj.save!
        @inv.details.each do |detail|
          detail.inventory_id = @inv.id
          detail.save!
        end
      end
    rescue ActiveRecord::RecordInvalid => e
      # Something wrong!
      raise e.inspect
      return
    end
      
    redirect_to({action:"show", id: @inv.id}, notice: 'Se realizó el ingreso de inventario.')
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
