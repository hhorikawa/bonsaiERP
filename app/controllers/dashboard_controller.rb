
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
    if params[:date_range].blank?
      today = Date.today
      # `DateRange` is a form object.
      @date_range = DateRange.new date_start: today - 366, date_end: today,
                                  time_strata: 'month'
    else
      @date_range = DateRange.new params.require(:date_range)
                                        .permit(*DateRange.attribute_names)
    end
    
    @report = Report.new @date_range
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
