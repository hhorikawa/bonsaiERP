
class HomeController < ApplicationController
  skip_before_action :require_login
  skip_before_action :check_authorization!
  
  # テナントを見て, 分岐する
  def index
if USE_SUBDOMAIN
    if Apartment::Tenant.current != "public"
      redirect_to '/dashboard'
    else
      redirect_to '/user_session/new'
    end
else
    redirect_to '/dashboard'
end  # USE_SUBDOMAIN  
  end
end
