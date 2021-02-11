require 'dry-initializer'
require 'dry-equalizer'
require 'securerandom'

files = "#{File.dirname(__FILE__)}/**/*.rb"
Dir[files].uniq.each { |file| require file }

module Domain
end
