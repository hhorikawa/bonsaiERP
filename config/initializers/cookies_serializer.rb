# Be sure to restart your server when you modify this file.

# Specify a serializer for the signed and encrypted cookie jars.
# Valid options are :json, :marshal, and :hybrid.
Rails.application.config.action_dispatch.cookies_serializer = :json

# Set to false to maintain compatibility with Rails 5.1 cookies
# This allows cookies to be read by Rails 5.1 and older versions
Rails.application.config.action_dispatch.use_authenticated_cookie_encryption = false
