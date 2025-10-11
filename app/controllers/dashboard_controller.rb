
# author: Boris Barroso
# email: boriscyber@gmail.com
class DashboardController < ApplicationController
  #include Controllers::DateRange

  #before_action :set_date_range, only: [:show]

  skip_before_action :check_authorization!, only: [:home]
  #before_action :check_user_session

  # GET /home
  def home
    render template: 'dashboard/home'
  end

  # GET /dashboard
  def show
    @date_range = DateRange.new params[:date_range]
    @report = Report.new @date_range
    #@dashboard = DashboardPresenter.new(view_context, @date_range)
    #render template: 'dashboard/index'
  end


private

=begin
   def check_user_session
      unless current_user
        redirect_to logout_path and return
      end
    end
=end
  
end
