# encoding: utf-8
# author: Boris Barroso
# email: boriscyber@gmail.com
class UnitsController < ApplicationController
  before_action :set_unit, only: [:edit, :update, :destroy]
  

  # GET /units
  def index
    @units = Unit.all
  end

=begin  一覧画面のみ
  # GET /units/1
  def show
    @unit = Unit.find(params[:id])
    #respond_with @unit
  end
=end
  
  # GET /units/new
  def new
    @unit = Unit.new
    #respond_with @unit
  end

  # GET /units/1/edit
  def edit
  end

  # POST /units
  def create
    @unit = Unit.new(unit_params)

    if @unit.save
      redirect_to units_path
    else
      render :new, status: :unprocessable_entity 
    end
  end

  # PUT /units/1
  def update
    begin
      @unit.update!(unit_params)
    rescue ActiveRecord::RecordInvalid => e
      render :edit, status: :unprocessable_entity 
      return
    end
    redirect_to units_path
  end

  
  # DELETE /units/1
  def destroy
    #@unit = Unit.find(params[:id])
    @unit.destroy!
    if @unit.destroyed?
      flash[:notice] = "La unidad de medidad fue borrada."
    else
      flash[:error] = "No es posible borrar la unidad de medida."
    end

    redirect_to(units_url)
  end

  
private

  def set_unit
    @unit = Unit.find(params[:id])
  end
  
    def unit_params
      params.require(:unit).permit(:name, :symbol)
    end
end
