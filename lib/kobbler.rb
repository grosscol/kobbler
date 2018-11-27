require 'find'
require 'json'
require 'yaml'

# @author Colin Gross
# Utility class providing functionality for building kgrid objects
class Kobbler
  
  def self.kobble(input_dir, output_dir=nil)
    if input_dir.nil?
      puts "Input directory required."
      return
    end

    # output defaults to current directory
    output_dir ||= Dir.new(Dir.pwd)

    # get metadata from file in directory
    metadata = load_metadata(input_dir)

    # build knowledge object metadata
    #
    # build model metadata
    #
    # build open api service description
    #
    # build zip file


  end

  # Loads metadata into a hash
  #
  # @param input_dir [String] path to directory containing a metadata.yml
  # @return [Hash] data loaded from file or empty.
  def self.load_metadata(input_dir)
    metadata_path = File.join(input_dir, 'metadata.yml')
    if File.exists? metadata_path
      YAML.load_file(metadata_path)
    else
      {}
    end
  end

  def self.resolve_adapter_type(path)
    case File.extname(path)
    when '.rb'
      'Ruby'
    when '.r'
      'R'
    when '.py'
      'Python'
    when '.sh'
      'Bash'
    when '.js'
      'Javascript'
    else
      'RESOURCE'
    end
  end

end
