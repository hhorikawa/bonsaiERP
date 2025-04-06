# Be sure to restart your server when you modify this file.

# Rails 6 uses ActionDispatch::Session::CookieStore with ActiveSupport::MessageVerifier by default
# Use a new key to force all old sessions to be invalidated
BonsaiErp::Application.config.session_store :cookie_store, 
                                           key: '_bonsai_rails6_session', 
                                           domain: :all

# Set SameSite cookie policy for Rails 6
Rails.application.config.action_dispatch.cookies_same_site_protection = :lax
