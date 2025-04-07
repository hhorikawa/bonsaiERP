# BonsaiERP Upgrade Checklist

## Updated Migration Goal (April 6, 2025)
- [ ] Migrate from Rails 5.2 to Rails 8.0 with Propshaft and Tailwind CSS
- [ ] Maintain all existing business logic and user journeys
- [ ] Modernize frontend with Tailwind CSS
- [ ] Replace Sprockets with Propshaft for asset pipeline
- [ ] Convert CoffeeScript to modern JavaScript (Priority)

## Ruby Upgrade Path
- [x] Upgrade from Ruby 2.3.1 to Ruby 2.6.4 (skipped 2.5 as 2.6.4 was available)
- [ ] Upgrade from Ruby 2.6.4 to Ruby 3.0.6
- [ ] Upgrade from Ruby 3.0.6 to Ruby 3.2.3
- [ ] Upgrade from Ruby 3.2.3 to Ruby 3.3.0 (for Rails 8 compatibility)

## Rails Upgrade Path
- [x] Upgrade from Rails 4.2.7.1 to Rails 5.0.7.2
- [x] Upgrade from Rails 5.0 to Rails 5.1
- [x] Upgrade from Rails 5.1 to Rails 5.2
- [ ] Upgrade from Rails 5.2 to Rails 6.0
- [ ] Upgrade from Rails 6.0 to Rails 6.1
- [ ] Upgrade from Rails 6.1 to Rails 7.0
- [ ] Upgrade from Rails 7.0 to Rails 7.1.x
- [ ] Upgrade from Rails 7.1.x to Rails 8.0

## Phase 1: Rails 6.0 Upgrade (Current Phase)
- [x] Update deprecated ActiveRecord query methods
- [x] Change `before_filter` to `before_action`
- [x] Change `redirect_to :back` to `redirect_back(fallback_location: root_path)`
- [x] Review and update controller parameters handling
- [x] Replace deprecated `update_attributes` with `update` (Rails 5.2)
- [x] Update migration files to specify Rails version (Rails 5.2)
- [x] Update i18n.fallbacks configuration for Rails 5.2 compatibility
- [x] Replace deprecated sanitize_sql_array with sanitize_sql_for_conditions
- [x] Add new_framework_defaults_5_2.rb initializer
- [x] Configure ActiveStorage routes for Rails 5.2
- [x] Add Content Security Policy (CSP) configuration for Rails 5.2
- [x] Set up ActiveStorage database tables for Rails 5.2
- [x] Converted views from Spanish to English for improved localization
- [x] Translated JavaScript messages from Spanish to English
- [x] Converted HAML templates to ERB format for better Rails 6 compatibility
- [x] Updated controllers to explicitly render templates for Rails 6 compatibility
- [ ] Update Rails version to 6.0 in Gemfile
- [ ] Add webpacker gem for JavaScript bundling in Rails 6.0
- [ ] Install and configure Webpacker
- [ ] Add zeitwerk for code autoloading in Rails 6.0
- [ ] Add Active Storage dependencies (image_processing, mini_magick)
- [ ] Configure Action Text if needed
- [ ] Run tests and fix failing tests
- [ ] Update database configuration for Rails 6.0 compatibility
- [ ] Begin converting critical CoffeeScript files to plain JavaScript

## Phase 2: Rails 6.1 Upgrade
- [ ] Update Rails version to 6.1 in Gemfile
- [ ] Update gem dependencies for Rails 6.1 compatibility
- [ ] Add new_framework_defaults_6_1.rb initializer
- [ ] Update configuration files for Rails 6.1
- [ ] Update ActiveRecord patterns for Rails 6.1
- [ ] Run tests and fix failing tests
- [ ] Continue CoffeeScript to JavaScript conversion

## Phase 3: Rails 7.0 Upgrade
- [ ] Update Rails version to 7.0 in Gemfile
- [ ] Update gem dependencies for Rails 7.0 compatibility
- [ ] Add new_framework_defaults_7_0.rb initializer
- [ ] Replace Webpacker with importmaps or jsbundling-rails
- [ ] Update configuration files for Rails 7.0
- [ ] Run tests and fix failing tests
- [ ] Complete CoffeeScript to JavaScript conversion

## Phase 4: Rails 7.1 Upgrade
- [ ] Update Rails version to 7.1 in Gemfile
- [ ] Update gem dependencies for Rails 7.1 compatibility
- [ ] Add new_framework_defaults_7_1.rb initializer
- [ ] Update configuration files for Rails 7.1
- [ ] Run tests and fix failing tests

## Phase 5: Rails 8.0 with Propshaft and Tailwind CSS
- [ ] Update Rails version to 8.0 in Gemfile
- [ ] Replace Sprockets with Propshaft
- [ ] Update stylesheet_link_tag to use Propshaft syntax
- [ ] Install and configure Tailwind CSS
- [ ] Migrate existing CSS to Tailwind classes
- [ ] Update configuration files for Rails 8.0
- [ ] Run tests and fix failing tests

## Asset Pipeline Modernization
- [ ] Replace Sprockets with Propshaft (Rails 8 default)
- [ ] Update asset compilation configuration for Propshaft
- [x] Convert CoffeeScript files to modern JavaScript (High Priority)
  - [x] Convert application.js.coffee to application.js
  - [x] Convert base.coffee to base.js
  - [x] Convert forms.coffee to forms.js
  - [x] Convert links.coffee to links.js
  - [x] Convert controllers/*.coffee to controllers/*.js
  - [x] Convert plugins/*.coffee to plugins/*.js
  - [x] Convert services/*.coffee to services/*.js
  - [x] Convert directives/*.coffee to directives/*.js
- [ ] Migrate from SASS to Tailwind CSS
  - [ ] Install Tailwind CSS
  - [ ] Create Tailwind configuration file
  - [ ] Convert existing CSS classes to Tailwind utility classes
  - [ ] Update views to use Tailwind classes
  - [ ] Create custom components with Tailwind
- [ ] Test asset precompilation in production mode

## JavaScript Framework Modernization
- [ ] Evaluate options for JavaScript framework
  - [ ] Stimulus (Hotwire) for minimal JavaScript needs
  - [ ] React for more complex UI components
- [ ] Set up JavaScript bundling with esbuild or Vite
- [ ] Migrate jQuery-dependent code to modern JavaScript
- [ ] Update AJAX calls to use fetch API or Turbo
- [ ] Implement Turbo for SPA-like experience

## JavaScript Testing Plan
- [ ] Create standalone test environment for JavaScript files
  - [x] Create js_test.html for basic functionality testing
  - [ ] Test core JavaScript functions independently
  - [ ] Verify jQuery plugin extensions work correctly
- [ ] Test JavaScript in the context of the application
  - [ ] Fix asset pipeline issues to load JavaScript properly
  - [ ] Verify AJAX functionality works as expected
  - [ ] Test form submissions and validations
- [ ] Document any issues found during testing

## CSS/Sass Migration Plan
- [ ] Address immediate Sass compatibility issues with Rails 6
  - [ ] Fix Sprockets file not found errors
  - [ ] Update Sass syntax for compatibility
- [ ] Plan Tailwind CSS integration
  - [ ] Install Tailwind CSS dependencies
  - [ ] Create initial Tailwind configuration
  - [ ] Identify key UI components to convert first
  - [ ] Develop component migration strategy
- [ ] Implement progressive Tailwind migration
  - [ ] Convert core UI components to Tailwind
  - [ ] Create custom Tailwind components for repeated UI patterns
  - [ ] Ensure responsive design works correctly

## Database Adaptations
- [x] Test schema management with newer PostgreSQL drivers
- [x] Update `hstore_accessor` for compatibility
- [x] Fix database migration issues related to PostgreSQL roles and indexes
- [x] Review and update database migrations for compatibility
- [ ] Test multi-tenancy implementation with newer Rails versions
- [ ] Resolve tenant name validation issues in seed data
- [ ] Create proper seed data for development environment
- [ ] Test database structure dump with PostgreSQL 16
- [ ] Update to latest PostgreSQL adapter

## Authentication System
- [ ] Review custom authentication in `Models::User::Authentication`
- [ ] Update password hashing if necessary
- [ ] Test user authentication flows
- [ ] Update session management
- [ ] Consider adding modern authentication options

## Testing
- [x] Run tests after each incremental upgrade
- [ ] Update test suite for Rails 6+ compatibility
- [ ] Add system tests using Capybara and Selenium
- [ ] Fix failing tests
- [ ] Add tests for critical functionality if missing
- [ ] Perform manual testing of key user flows

## Deployment
- [ ] Update deployment scripts
- [ ] Update Capistrano configuration for Rails 8
- [ ] Configure asset compilation with Propshaft
- [ ] Test deployment to staging environment
- [ ] Create rollback plan
- [ ] Schedule production deployment

## Post-Upgrade
- [ ] Monitor application performance
- [ ] Address any issues that arise
- [ ] Document changes made during the upgrade
- [ ] Update developer documentation
- [ ] Optimize Tailwind CSS for production
- [ ] Implement performance monitoring

## Current Progress (Updated: April 6, 2025)
- [x] Successfully upgraded from Ruby 2.3.1 to Ruby 2.6.4
- [x] Successfully upgraded from Rails 4.2.7.1 to Rails 5.0.7.2
- [x] Updated deprecated code patterns like before_filter to before_action
- [x] Updated deprecated render text: to render plain:
- [x] Updated deprecated config.serve_static_files to config.public_file_server.enabled
- [x] Updated Rails to version 5.1.7 and updated gem dependencies
- [x] Successfully upgraded from Rails 5.1 to Rails 5.2
- [x] Completed Compass-to-mixins migration
- [x] Updated deprecated find_by_* dynamic finders to find_by(attribute: value)
- [x] Updated deprecated update_attributes and update_attributes! to update and update!
- [x] Converted views from Spanish to English for improved localization
- [x] Translated JavaScript messages from Spanish to English
- [x] Converted HAML templates to ERB format for better Rails 6 compatibility
- [x] Updated controllers to explicitly render templates for Rails 6 compatibility
- [ ] Currently working on Rails 6.0 upgrade
- [x] Completed replacing CoffeeScript with plain JavaScript
- [ ] Testing JavaScript functionality after CoffeeScript migration
- [ ] Address CSS/Sass compatibility issues with Rails 6
- [ ] Plan migration from Sass to Tailwind CSS
