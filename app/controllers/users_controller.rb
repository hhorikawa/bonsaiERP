# encoding: utf-8 # author: Boris Barroso
# email: boriscyber@gmail.com
class UsersController < ApplicationController

  before_action :set_user, only: [:show, :edit]

  # GET /users/:id
  def show
  end

  # GET /users/:id/edit
  def edit
  end

  # PUT /users/:id
  def update
    @user = current_user
    
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "Se ha actualizado correctamente sus datos."
    else
      render 'edit'
    end
  end

  private

    def set_user
      @user = current_user
    end

    def user_params
      params.require(:user).permit(
        :email,
        :first_name, :last_name,
        :address, :phone, :mobile
      )
    end
end
