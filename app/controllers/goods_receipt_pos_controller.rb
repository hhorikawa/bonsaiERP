
# author: Boris Barroso
# email: boriscyber@gmail.com

# 購買入庫
class GoodsReceiptPosController < ApplicationController
  before_action :set_store

  before_action :set_inv, only: [:show, :edit, :update, :destroy, :confirm, :void]

  
  def index
    @orders = PurchaseOrder.confirmed.where(store_id: @store.id)
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
                              operation: 'exp_in',
                              state: 'draft' )
    @inv.assign inventory_params, params.require(:detail), @store.id

    begin
      ActiveRecord::Base.transaction do
        # atomic save in form object
        @inv.save!

        # TODO:
        # To prevent double submissions, the balances is subtracted even in
        # draft state. It also needs to update them when updating. This is not
        # efficient.
        
        # subtract from the order balance.
        @inv.model_obj.details.each do |inv_detail|
          m = MovementDetail.where(order_id: @inv.model_obj.order_id,
                                   item_id: inv_detail.item_id).take ||
              MovementDetail.new(order_id: @inv.model_obj.order_id,
                                 item_id: inv_detail.item_id,
                                 price: inv_detail.price) # new price
          m.balance -= inv_detail.quantity
          m.save!
        end
      end
    rescue ActiveRecord::RecordInvalid => e
      render :new, status: :unprocessable_entity
      return
    end
      
    redirect_to({action:"show", id: @inv.model_obj},
                notice: 'Se realizó el ingreso de inventario.')
  end


  def show
  end


  # POST
  def confirm
    authorize @inv

    # journal entry
    # TODO: 1件ごとに作っていては件数がバカにならない. 集約して, 夜間バッチに
    #       するか?
    amt = {}
    @inv.details.each do |detail|
      amt[detail.item.accounting.stock_ac_id] =
                        (amt[detail.item.accounting.stock_ac_id] || 0) +
                        detail.price * detail.quantity
    end

    begin
      ActiveRecord::Base.transaction do
        @inv.confirm! current_user
        @inv.save!

        # Dr.
        sum_amt = 0
        amt.each do |ac_id, a|
          r = AccountLedger.new date: @inv.date,
                            operation: 'trans',
                            account_id: ac_id,  # Dr.
                            amount: a,  # 取引通貨
                            currency: @inv.order.currency,
                            description: "goods receipt po",
                            creator_id: current_user.id,
                            status: 'approved',
                            inventory_id: @inv.id
          r.save!
          sum_amt += a
        end
        # Cr.
        r = AccountLedger.new date: @inv.date,
                            operation: 'trans',
                            account_id: @inv.account_id,
                            amount: -sum_amt,  # 取引通貨, 貸方マイナス
                            currency: @inv.order.currency,
                            description: "goods receipt po",
                            creator_id: current_user.id,
                            status: 'approved',
                            inventory_id: @inv.id
        r.save!
      end # transaction
    rescue ActiveRecord::RecordInvalid => e
      raise e.inspect
      return
    end
      
    redirect_to({action:"show", id: @inv})
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
    authorize @inv
    
    @inv.destroy!
    # TODO: impl.
  end

  
  # POST
  def void
    authorize @inv

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
        :description, :date, :account_id,
        #inventory_details_attributes: [:item_id, :quantity]
      )
  end
end
