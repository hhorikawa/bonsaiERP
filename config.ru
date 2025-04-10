# This file is used by Rack-based servers to start the application.

require_relative "config/environment"

run Rails.application
Rails.application.load_server

# # This file is used by Rack-based servers to start the application.
# require ::File.expand_path('../config/environment',  __FILE__)
# use Rack::Deflater # Compress css and javasript
# run BonsaiErp::Application
