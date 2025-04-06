# encoding: utf-8
# author: Boris Barroso
# email: boriscyber@gmail.com

# Define the Controllers module to ensure proper loading in Rails 6
module Controllers
end

# Require all controller modules
Dir[File.join(File.dirname(__FILE__), 'controllers', '*.rb')].each do |file|
  require file
end
