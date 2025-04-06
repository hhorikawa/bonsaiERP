class ConfigurationsController < ApplicationController
  # GET /configurations
  def index
    # Explicitly render the ERB template
    render 'index'
  end
end
