
# Apartment の使い方は、ここが詳しい
#   https://qiita.com/kakipo/items/a584d24771dff019d3a9
#   Apartment でマルチテナントサービスを作成する

# Used to create sample data

# NOTE: There are several issues with creating seed data:
# 1. The tenant name must be unique, 3-14 characters, and only contain lowercase letters and numbers
# 2. The tenant is automatically generated from the organization name in the set_tenant method
# 3. There's a validation against INVALID_TENANTS list
# 4. The PostgreSQL version mismatch between server and pg_dump utility needs to be resolved
#    (symbolic link from PostgreSQL 16's pg_dump to PostgreSQL 14's pg_dump location works)

puts "Creating seed data for BonsaiERP..."

# Create organization with a unique tenant name
org_name = "Kintsugi"
org_tenant = "kintsugi#{Time.now.to_i.to_s[-5..-1]}" # Use timestamp to ensure uniqueness

org = Organisation.new(
  name: org_name,
  tenant: org_tenant,
  inventory: true,
  country_code: 'US',
  currency: 'USD',
  email: 'admin@kintsugi.design'
)

# Save the organization
if org.save
  puts "Organization '#{org.name}' has been created with tenant '#{org.tenant}'"
  
  # Create admin user
  user = User.new(
    email: 'admin@kintsugi.design',
    password: 'password123',
    password_confirmation: 'password123',
    first_name: 'Admin',
    last_name: 'User'
  )
  
  # Set confirmation token and confirm the user
  user.set_confirmation_token if user.respond_to?(:set_confirmation_token)
  user.confirmed_at = Time.now if user.respond_to?(:confirmed_at=)
  
  # Create link between user and organization
  link = user.active_links.build(
    organisation_id: org.id,
    tenant: org.tenant,
    role: 'admin',
    master_account: true,
    active: true,
    api_token: SecureRandom.urlsafe_base64(32)
  )
  
  if user.save
    puts "User #{user.email} has been created with password: password123"
    
    # Note: We don't need to create OrgCountry records as the app uses the Country model
    # which is a Struct based on the COUNTRIES constant
    
    # Load currencies if needed
    if defined?(Currency) && Currency.respond_to?(:count) && Currency.count == 0
      begin
        puts "Attempting to create currencies..."
        YAML.load_file(Rails.root.join('db/defaults/currencies.yml')).each do |c|
          Currency.create!(c) {|cu| cu.id = c['id'] }
        end
        puts "Currencies have been created"
      rescue => e
        puts "Error creating currencies: #{e.message}"
        puts "This is not critical - you can still log in to the application"
      end
    end
    
    puts "\n==============================================="
    puts "Seed data created successfully!"
    puts "You can now login with:"
    puts "Email: admin@kintsugi.design"
    puts "Password: password123"
    puts "Tenant: #{org.tenant}"
    puts "==============================================="
  else
    puts "Failed to create user:"
    puts user.errors.full_messages
  end
else
  puts "Failed to create organization:"
  puts org.errors.full_messages
end
