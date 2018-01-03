# Add the utils directory to ruby load path
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'find'

require 'kobbler'
require 'krest'

task :default => :kobble

desc "Make knowledge objects for all payloads under src/"
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

desc "Stuff assembled knowledge object into activator."
task :activate, [:kobject_name] do |task, args|
  unless args[:kobject_name]  
    puts "kobject_name required. e.g. activate['hello-js']"
    next
  end

  kobject_path = File.join("build", "#{args[:kobject_name]}.json")
  unless File.exist?(kobject_path)
    puts "#{kobject_path} not found." 
    next
  end

  puts "Putting #{args[:kobject_name]} into activator."
  Krest.put(kobject_path)
end

desc "Test knowledge object in activator."
task :test, [:kobject_name] do |task, args|
  unless args[:kobject_name]  
    puts "kobject_name required. e.g. test['hello-js']"
    next
  end

  kobject_path = File.join("build", "#{args[:kobject_name]}.json")
  unless File.exist?(kobject_path)
    puts "#{kobject_path} not found." 
    next
  end

  test_data_path = File.join("src", args[:kobject_name], "test", "input.json")
  unless File.exist? test_data_path
    puts "#{test_data_path} not found."
    next
  end

  puts "Testing #{args[:kobject_name]}."
  Krest.test(kobject_path, test_data_path)
end
