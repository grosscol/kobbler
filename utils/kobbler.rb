require 'find'
require 'json'
require 'yaml'
require 'rdf'
require 'erubis'

class Kobbler
  INPUT_MESSAGE_ERB_FILE  = File.expand_path('../templates/input_message.xml.erb', __FILE__)
  OUTPUT_MESSAGE_ERB_FILE = File.expand_path('../templates/output_message.xml.erb', __FILE__)
  
  INPUT_MESSAGE_TEMPLATE  = File.read(INPUT_MESSAGE_ERB_FILE)
  OUTPUT_MESSAGE_TEMPLATE = File.read(OUTPUT_MESSAGE_ERB_FILE)

  def self.kobble(input_dir)
    if input_dir.nil?
      puts "Input directory required."
      return
    end

    # output to current directory
    output_dir = Dir.new(Dir.pwd)

    # get params hash
    params = load_params(input_dir)

    # get payload hash
    payload = load_payload(input_dir)

    # construct input message based on params
    input_message = build_template(params, INPUT_MESSAGE_TEMPLATE)

    # construct output message based on params
    output_message = build_template(params, OUTPUT_MESSAGE_TEMPLATE)

    # create knowledge object hash
    kobject = { inputMessage: input_message,
                outputMessage: output_message,
                payload: payload,
                url: "demourl"}

    # write knowledge object
    outfile_name = "#{File.basename(input_dir)}.json"
    File.write( File.join(Dir.pwd, outfile_name), kobject.to_json ) 
  end

  def self.build_template(params, template)
    template = Erubis::Eruby.new(template)
    template.result(params)
  end

  def self.load_params(input_dir)
    params_path = find_params_file(input_dir)
    if params_path
      YAML.load_file(params_path)
    else
      {}
    end
  end

  def self.load_payload(input_dir)
    payload_path = find_payload_file(input_dir)
    return {} unless payload_path

    # return a hash of the payload
    { contents: File.read(payload_path),
      function_name: "perform",
      engine_type: resolve_engine(payload_path) }
  end

  def self.find_payload_file(input_dir)
    filename = Dir.entries(input_dir).find do |entry|
      File.basename(entry,'.*') == 'payload'
    end
    File.join(input_dir, filename) if filename
  end

  def self.find_params_file(input_dir)
    filename = Dir.entries(input_dir).find do |entry|
      File.basename(entry) == 'params.yml'
    end
    File.join(input_dir, filename) if filename
  end

  def self.resolve_engine(path)
    case File.extname(path)
    when '.rb'
      'Ruby'
    when '.r'
      'R'
    when '.py'
      'Python'
    when '.sh'
      'Bash'
    else
      'Unknown'
    end
  end

end
