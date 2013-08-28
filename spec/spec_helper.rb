ENV['RACK_ENV'] = 'test'

require 'minitest/autorun'
require 'minitest/pride'

# pull in the code to test
require File.expand_path '../app.rb', __dir__
