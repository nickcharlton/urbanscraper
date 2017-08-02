##
# Initialise Bundler, catch errors.
##
require "bundler"

begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems."
  exit e.status_code
end

##
# Configure the test suite.
##
require "rspec/core"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new

##
# By default, just run the tests.
##
task default: :spec
