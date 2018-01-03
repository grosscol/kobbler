require 'typhoeus'
require 'json'
require 'pry'

class Krest

  def self.put(kobject_path, activator_url=nil)
    activator_url ||= "localhost:8080"
    endpoint    = "#{activator_url}/shelf"

    # Read knowledge object
    kobject_json = File.read(kobject_path)
    kobject = JSON.parse(kobject_json)
    
    # Stuff knowledge object into activator
    headers = {"Content-Type": "application/json"}
    target_url = "#{endpoint}/#{kobject['uri']}"
    
    resp = Typhoeus.put(target_url, headers: headers, body: kobject_json)

    print_response(resp)
  end

  def self.test(kobject_path, data_path, activator_url=nil)
    activator_url ||= "localhost:8080"
    endpoint = "#{activator_url}/knowledgeObject"

    # Read knowledge object
    kobject = JSON.parse(File.read(kobject_path))

    # Post test data to knowledge object in activator
    headers = {"Content-Type": "application/json",
               "Accept-Encoding": "application/json"}
    target_url = "#{endpoint}/#{kobject['uri']}/result"

    resp = Typhoeus.post(target_url, headers: headers, body: File.read(data_path))

    print_response(resp)
  end

  def self.print_response(resp)
    puts "Response Code: #{resp.code}"
    if resp.response_headers =~ Regexp.new("Content-Type: application/json")
      pp JSON.parse(resp.body)
    else
      pp resp.body
    end
  end
end
