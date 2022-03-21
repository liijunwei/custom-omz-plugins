#!/usr/bin/ruby

require 'fileutils'

old_filename = ARGV[0]
new_filename = old_filename.sub(/\d{14}/, Time.now.strftime("%Y%m%d%H%M%S"))

puts "old_filename: #{old_filename}"
puts "new_filename: #{new_filename}"

FileUtils.mv(old_filename, new_filename)

puts "=================="
puts "filename corrected"
