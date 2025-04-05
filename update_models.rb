#!/usr/bin/env ruby

# Script to update models to inherit from ApplicationRecord instead of ActiveRecord::Base
require 'fileutils'

model_files = Dir.glob('app/models/**/*.rb').reject { |f| f == 'app/models/application_record.rb' }

model_files.each do |file|
  content = File.read(file)
  if content.include?('ActiveRecord::Base')
    puts "Updating #{file}"
    updated_content = content.gsub(/< ActiveRecord::Base/, '< ApplicationRecord')
    File.write(file, updated_content)
  end
end

puts "Updated #{model_files.count} model files"
