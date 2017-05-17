# Add the utils directory to ruby load path
utils = File.expand_path('../utils', __FILE__)
$LOAD_PATH.unshift(utils) unless $LOAD_PATH.include?(utils)

require 'kobbler'
require 'find'
require 'pry'

# by default kobble all the things
task :default => :kobble

# Find the payloads in the src directory and make knowledge objects
task :kobble do
  puts "Kobbling all payloads into ./build"

  output_dir = File.expand_path('../build', __FILE__)
  src_dir    = File.expand_path('../src', __FILE__)
  
  # Find all payload files in the src directory
  payloads = []
  Find.find(src_dir) do |path|
    payloads << path if File.basename(path, '.*') == 'payload'
  end

  # Run Kobbler on the directory containing the payload
  payloads.each do |path|
    puts "Running kobbler for #{path}"
    Kobbler.kobble(File.expand_path('..', path), output_dir)
  end
end

# Alias for kobble
task :cobble => :kobble
