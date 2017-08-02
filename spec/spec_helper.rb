require "rack/test"
require "rspec"
require "pry"

require File.expand_path "./support/vcr_setup.rb", __dir__

require File.expand_path "../../app", __FILE__

ENV["RACK_ENV"] = "test"

RSpec.configure do |c|
  c.include Rack::Test::Methods

  def app
    Sinatra::Application
  end
end
