USECASES_FOLDER = "#{File.dirname(__FILE__)}/usecases".freeze
base_files = "#{USECASES_FOLDER}/*.rb"
responses = "#{USECASES_FOLDER}/**/*_response.rb"
requests = "#{USECASES_FOLDER}/**/*_request.rb"
usecases = "#{USECASES_FOLDER}/**/*.rb"

Dir[base_files, responses, requests, usecases].uniq.each { |file| require file }

module App
end
