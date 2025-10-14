
# author: Boris Barroso
# email: boriscyber@gmail.com

# 発注
class PurchaseOrdersController < ApplicationController
  include Controllers::TagSearch

  before_action :set_order, only: [:show, :edit, :update, :destroy, :approve, :null, :inventory]

  # GET /expenses
  def index
    if params[:movements_search].blank? || !params[:reset].blank?
      @search = Movements::Search.new
    else
      @search = Movements::Search.new params.require(:movements_search)
                                        .permit(*Movements::Search.attribute_names)
    end

    @orders = @search.search_by_text(PurchaseOrder).order(date: :desc).page(params[:page])
  end

  
  # GET /expenses/1
  def show
    #@expense = present Expense.find(params[:id])
  end

  # GET /expenses/new
  def new
    # Use the form object.
    #@order = Expenses::Form.new_expense(currency: currency)
    @order = PurchaseOrder.new
    @order_details = []
  end

  # GET /expenses/1/edit
  def edit
    #@es = Expenses::Form.find(params[:id])
  end

  # POST /expenses
  def create
    # the form object
    #es = Expenses::Form.new_expense(expense_params)
    
    @order = PurchaseOrder.new expense_params 
    @order_details = PurchaseOrder.create_details_from_params(params.require(:order_details))
    if create_or_approve
      redirect_to expense_path(@es.expense), notice: 'Se ha creado un Egreso.'
    else
      @es.movement.state = 'draft' # reset status
      render :new, status: :unprocessable_entity
    end
  end

  
  # PATCH /expenses/:id
  def update
    #@es = Expenses::Form.find(params[:id])
    
    if update_or_approve
      redirect_to expense_path(@es.expense), notice: 'El Egreso fue actualizado!.'
    else
      render :edit, status: :unprocessable_entity 
    end
  end


  # PATCH /expenses/1/approve
  # Method to approve an expense
  def approve
    #@expense = Expense.find(params[:id])
    if !@order.draft?
      redirect_to(@order, alert: 'El Ingreso ya esta aprovado')
      return
    end
    
    @order.approve! current_user
    if @order.save
      flash[:notice] = "La nota de venta fue aprobada."
    else
      flash[:error] = "Existio un problema con la aprobación."
    end

    redirect_to purchase_order_path(@order)
  end

  
  # PATCH /expenses/:id/approve
  # Method that nulls or enables inventory
  def inventory
    @expense.inventory = !@expense.inventory?
    @expense.extras = @expense.extras.symbolize_keys

    if @expense.save
      txt = @expense.inventory? ? 'activo' : 'desactivó'
      flash[:notice] = "Se #{txt} los inventarios."
    else
      flash[:error] = 'Exisition un error'
    end

    redirect_to expense_path(@expense.id, anchor: 'items')
  end

  
  # PATCH /incomes/:id/null
  def null
    if @expense.null!
      redirect_to expense_path(@expense), notice: 'Se anulo correctamente el egreso.'
    else
      redirect_to expense_path(@expense), error: 'Existio un error al anular el egreso.'
    end
  end

  
  def destroy
    @order.destroy!
    #TODO impl.
  end

  
private

  # Creates or approves a Expenses::Form instance
    def create_or_approve
      if params[:commit_approve]
        @es.create_and_approve
      else
        @es.create
      end
    end

    def update_or_approve
      if params[:commit_approve]
        @es.update_and_approve(expense_params)
      else
        @es.update(expense_params)
      end
    end

    def quick_expense_params
     params.require(:expenses_quick_form).permit(*movement_params.quick_income)
    end

    def expense_params
      params.require(:expenses_form).permit(*movement_params.expense)
    end

    def movement_params
      @movement_params ||= MovementParams.new
    end

  # before_action()
  def set_order
    @order = PurchaseOrder.find params[:id]
  end

=begin  
    # Method to search expenses on the index
    def search_expenses
      if tag_ids
        @expenses = Expenses::Query.index_includes Expense.any_tags(*tag_ids)
      else
        @expenses = Expenses::Query.new.index(params).order('date desc, accounts.id desc')
      end

      set_expenses_filters
      @expenses = @expenses.page(@page)
    end
=end
  
    def set_expenses_filters
      [:approved, :error, :due, :nulled, :inventory].each do |filter|
        @expenses = @expenses.send(filter)  if params[filter].present?
      end
    end

    def set_index_params
      params[:all] = true unless [:approved, :error, :nulled, :due, :inventory].any? {|v| params[v].present? }
    end
end
