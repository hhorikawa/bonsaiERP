# BonsaiERP Upgrade Checklist

## Ruby Upgrade Path
- [x] Upgrade from Ruby 2.3.1 to Ruby 2.6.4 (skipped 2.5 as 2.6.4 was available)
- [ ] Upgrade from Ruby 2.6.4 to Ruby 3.0
- [ ] Upgrade from Ruby 3.0 to Ruby 3.2.x

## Rails Upgrade Path
- [x] Upgrade from Rails 4.2.7.1 to Rails 5.0.7.2
- [x] Upgrade from Rails 5.0 to Rails 5.1
- [ ] Upgrade from Rails 5.1 to Rails 5.2
- [ ] Upgrade from Rails 5.2 to Rails 6.0
- [ ] Upgrade from Rails 6.0 to Rails 6.1
- [ ] Upgrade from Rails 6.1 to Rails 7.0
- [ ] Upgrade from Rails 7.0 to Rails 7.1.x

## Preparation Phase
- [x] Set up comprehensive test coverage
- [ ] Create a staging environment that mirrors production
- [ ] Document all custom behaviors and integrations
- [x] Backup database and codebase
- [ ] Review current test suite and ensure it's running properly

## API Updates
- [x] Update deprecated ActiveRecord query methods
- [x] Change `before_filter` to `before_action`
- [x] Change `redirect_to :back` to `redirect_back(fallback_location: root_path)`
- [ ] Update other deprecated method calls
- [ ] Review and update controller parameters handling

## Gem Compatibility
- [ ] Update or replace `compass-rails` with Sass or modern CSS solutions
- [ ] Replace `virtus` with native Rails attributes or dry-types
- [x] Replace `factory_girl_rails` with `factory_bot_rails`
- [x] Remove `quiet_assets` (built into Rails 5+)
- [x] Update `simple_form` for compatibility
- [x] Convert HAML templates to ERB for compatibility
- [x] Update `kaminari` for compatibility
- [x] Update `bcrypt-ruby` for compatibility
- [x] Update `active_model_serializers` for compatibility
- [x] Update `resubject` for compatibility
- [x] Update `dragonfly` for compatibility
- [x] Update `rack-cors` for compatibility
- [x] Update testing gems for compatibility

## Database Adaptations
- [x] Test schema management with newer PostgreSQL drivers
- [x] Update `hstore_accessor` for compatibility
- [x] Fix database migration issues related to PostgreSQL roles and indexes
- [x] Review and update database migrations for compatibility
- [ ] Test multi-tenancy implementation with newer Rails versions
- [x] Fix PostgreSQL version mismatch between server and pg_dump utility
- [ ] Resolve tenant name validation issues in seed data
- [ ] Create proper seed data for development environment
- [ ] Test database structure dump with PostgreSQL 16

## Asset Pipeline Modernization
- [ ] Evaluate options: Sprockets, Propshaft, or webpack/esbuild
- [ ] Convert CoffeeScript to modern JavaScript
- [ ] Update SASS files for compatibility
  - [x] Created custom mixins.sass to replace Compass mixins
  - [ ] Replace all @import "compass" statements with @import "mixins"
  - [ ] Remove compass-rails gem after all Sass files are updated
- [ ] Update asset compilation configuration
- [ ] Test asset precompilation in production mode

## Authentication System
- [ ] Review custom authentication in `Models::User::Authentication`
- [ ] Update password hashing if necessary
- [ ] Test user authentication flows
- [ ] Update session management

## Testing
- [x] Run tests after each incremental upgrade
- [ ] Fix failing tests
- [ ] Add tests for critical functionality if missing
- [ ] Perform manual testing of key user flows

## Deployment
- [ ] Update deployment scripts
- [ ] Update Capistrano configuration
- [ ] Test deployment to staging environment
- [ ] Create rollback plan
- [ ] Schedule production deployment

## Post-Upgrade
- [ ] Monitor application performance
- [ ] Address any issues that arise
- [ ] Document changes made during the upgrade
- [ ] Update developer documentation

## Current Progress (Updated: April 4, 2025)
- [x] Successfully upgraded from Ruby 2.3.1 to Ruby 2.6.4
- [x] Successfully upgraded from Rails 4.2.7.1 to Rails 5.0.7.2
- [x] Updated deprecated code patterns like before_filter to before_action
- [x] Updated deprecated render text: to render plain:
- [x] Updated deprecated config.serve_static_files to config.public_file_server.enabled
- [x] Updated Rails to version 5.1.7 and updated gem dependencies
- [ ] Following incremental upgrade approach as outlined in this document
- [ ] Next steps: Continue updating remaining deprecated code patterns and prepare for Rails 5.2 upgrade
