# author: Boris Barroso
# email: boriscyber@gmail.com
class UserSessionsController < ApplicationController
  #before_action :redirect_www
  skip_before_action :require_login, only: [:new, :create]
  skip_before_action :check_authorization!
  
  layout "sessions"

  # sign_in と sign_up を兼ねる
  def new
    #@session = Session.new
    #render :new
  end

  def create
    #@session = Session.new(session_params)
    @user = login(params[:email], params[:password])
    if @user
      # TODO: テナントが一つだけのときは, テナントに転送
      flash.now[:notice] = 'Login successful'
      redirect_to "/organisations/"
    else
      flash.now[:alert] = 'Login failed'
      render action: 'new', status: :unprocessable_entity
    end
  end
  

=begin
      flash[:notice] = t("views.sessions.flash_login")
      redirect_to( path_sub(:home_url)) and return
=end


  def destroy
    logout
    redirect_to path_sub(:login_url, subdomain: "app"),
                notice: t("views.sessions.flash_login")
  end


private

=begin
    def check_logged_in
      if session[:tenant] && session[:user_id] && u = User.active.find(session[:user_id])
        redirect_to path_sub(:home_url), notice: t("views.sessions.flash_login")
      else
        reset_session
      end
    rescue
      reset_session
      redirect_to path_sub(:login_url), error: t("views.sessions.flash_no_user") and return
    end
=end
  
end
