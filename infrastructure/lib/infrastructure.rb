require 'rom'
require 'rom-sql'

require 'domain'

common = "#{File.dirname(__FILE__)}/common/*.rb"
infrastructure = "#{File.dirname(__FILE__)}/**/*.rb"

Dir[common, infrastructure].uniq
                           .reject { |file| file.include?('migrate') }
                           .each { |file| require file }

module Infrastructure
end
