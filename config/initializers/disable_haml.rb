# Temporarily disable HAML during the Rails 5 upgrade process
# This will make Rails use ERB templates instead of HAML
# Once the upgrade is complete, we can either:
# 1. Convert all HAML templates to ERB
# 2. Fix the HAML configuration to work with Rails 5

Rails.application.config.generators do |g|
  g.template_engine :erb
end

# Remove HAML from template handlers to force ERB usage
ActionView::Template.unregister_template_handler :haml if defined?(ActionView::Template)
