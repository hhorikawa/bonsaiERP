
# 品目マスタと勘定科目
class ItemAccountingsController < ApplicationController
  before_action :set_item_accounting, only: %i[ show edit update destroy ]

  # GET /item_accountings or /item_accountings.json
  def index
    @item_accountings = ItemAccounting.all
  end

  # GET /item_accountings/1 or /item_accountings/1.json
  def show
  end

  # GET /item_accountings/new
  def new
    @item_accounting = ItemAccounting.new
  end

  # GET /item_accountings/1/edit
  def edit
  end

  # POST /item_accountings or /item_accountings.json
  def create
    @item_accounting = ItemAccounting.new(item_accounting_params)

    respond_to do |format|
      if @item_accounting.save
        format.html { redirect_to @item_accounting, notice: "Item accounting was successfully created." }
        format.json { render :show, status: :created, location: @item_accounting }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @item_accounting.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /item_accountings/1 or /item_accountings/1.json
  def update
    respond_to do |format|
      if @item_accounting.update(item_accounting_params)
        format.html { redirect_to @item_accounting, notice: "Item accounting was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @item_accounting }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @item_accounting.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /item_accountings/1 or /item_accountings/1.json
  def destroy
    @item_accounting.destroy!

    respond_to do |format|
      format.html { redirect_to item_accountings_path, notice: "Item accounting was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  
private
  
  # Use callbacks to share common setup or constraints between actions.
  def set_item_accounting
    @item_accounting = ItemAccounting.find params[:id]
  end

  # Only allow a list of trusted parameters through.
  def item_accounting_params
    params.require(:item_accounting).permit(:name, :item_type, :stock_ac_id,
                        :revenue_ac_id, :purchase_ac_id, :ending_inv_ac_id)
  end
  
end
