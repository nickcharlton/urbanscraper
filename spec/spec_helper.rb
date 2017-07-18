ENV['RACK_ENV'] = 'test'

require 'minitest/autorun'
require 'minitest/pride'
require 'rack/test'

# pull in the VCR setup
require File.expand_path './support/vcr_setup.rb', __dir__

# pull in the code to test
require File.expand_path '../app.rb', __dir__
