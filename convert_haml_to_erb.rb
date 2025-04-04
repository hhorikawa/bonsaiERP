#!/usr/bin/env ruby
# Script to convert HAML templates to ERB
# This script will find all HAML files in the app/views directory and convert them to ERB

require 'fileutils'

def convert_haml_to_erb(haml_file)
  erb_file = haml_file.sub(/\.haml$/, '.erb')
  
  puts "Converting #{haml_file} to #{erb_file}"
  
  # Use the html2haml gem in reverse to convert HAML to ERB
  system("haml2erb #{haml_file} > #{erb_file}")
  
  if $?.success?
    puts "Successfully converted #{haml_file} to #{erb_file}"
    # Optionally, remove the original HAML file
    # FileUtils.rm(haml_file)
  else
    puts "Failed to convert #{haml_file}"
  end
end

# Find all HAML files in the app/views directory
haml_files = Dir.glob(File.join(File.dirname(__FILE__), 'app/views/**/*.haml'))

if haml_files.empty?
  puts "No HAML files found in app/views directory"
else
  puts "Found #{haml_files.size} HAML files to convert"
  
  # Check if haml2erb is installed
  unless system("which haml2erb > /dev/null 2>&1")
    puts "haml2erb not found. Installing..."
    system("gem install haml2erb")
  end
  
  # Convert each HAML file to ERB
  haml_files.each do |haml_file|
    convert_haml_to_erb(haml_file)
  end
  
  puts "Conversion complete!"
end
