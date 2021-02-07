$LOAD_PATH.unshift File.expand_path('../lib', __dir__)
require 'biblio/domain'
require 'minitest/autorun'

Biblio::Db::Container.init
