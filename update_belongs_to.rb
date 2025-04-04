#!/usr/bin/env ruby
# Script to update belongs_to associations to be compatible with Rails 5
# In Rails 5, belongs_to associations are required by default
# We need to add optional: true for associations that can be nil

require 'fileutils'

# List of models with associations that are likely optional
OPTIONAL_ASSOCIATIONS = {
  'account_ledger.rb' => ['contact', 'approver', 'nuller'],
  'inventory.rb' => ['store_to', 'contact', 'expense', 'income', 'project'],
  'account.rb' => ['contact', 'approver', 'nuller', 'tax'],
  'movement.rb' => ['contact', 'project']
}

def process_file(file_path)
  basename = File.basename(file_path)
  return unless OPTIONAL_ASSOCIATIONS.key?(basename)
  
  puts "Processing: #{file_path}"
  content = File.read(file_path)
  updated = false
  
  OPTIONAL_ASSOCIATIONS[basename].each do |association|
    # Match the belongs_to line for this association
    if content.match(/^\s*belongs_to\s+:#{association}(?:,|\s|$)/)
      # If it doesn't already have optional: true, add it
      unless content.match(/^\s*belongs_to\s+:#{association}.*optional:\s*true/)
        content.gsub!(/^\s*(belongs_to\s+:#{association}(?:,\s*[^)]*)?)((?:\s*\))?)\s*$/) do |match|
          if $1.include?("->")
            # Handle lambda syntax
            if $1.include?("}")
              "#{$1.chomp('}')}}, optional: true#{$2}"
            else
              "#{$1}, optional: true#{$2}"
            end
          elsif $1.include?(",")
            # Already has options
            "#{$1}, optional: true#{$2}"
          else
            # No options yet
            "#{$1}, optional: true#{$2}"
          end
        end
        updated = true
      end
    end
  end
  
  if updated
    File.write(file_path, content)
    puts "Updated: #{file_path}"
  else
    puts "No changes needed for: #{file_path}"
  end
end

# Process all model files that have optional associations
OPTIONAL_ASSOCIATIONS.keys.each do |basename|
  file_path = File.join(File.dirname(__FILE__), 'app/models', basename)
  process_file(file_path) if File.exist?(file_path)
end

puts "All models updated successfully!"
