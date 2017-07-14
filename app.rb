require 'sinatra'
require 'redcarpet'
require 'pygments'
require 'json'
require 'sinatra/jsonp'

require_relative 'helpers/markdown'
require_relative 'helpers/time'
require_relative 'helpers/response'
require_relative 'scrapers/urbandictionary'

#
# UrbanDictionary Global
#
ud = UrbanDictionary.new

# custom error handling classes
NoDefinition = Class.new(StandardError)

#
# Helpers
#
helpers TimeUtils, ResponseUtils

#
# Filters
#
before do
  # you can always cache until tomorrow
  expires :tomorrow
  # we'll always return json
  content_type :json
end

#
# Documentation
#
get '/' do
  # in this case, json isn't appropriate
  content_type :html

  markdown :home
end

#
#  Fetches a random definition by following the /random.php redirect
#  and taking out the term with a regexp
#
get '/random' do
  rdef = ud.get_random_definition()
    unless valid_response? definition
    raise NoDefinition, params[:term]
  end

  jsonp definition
end

#
# Get the Top Definition for a Term
#
get '/define/:term' do
  definition = ud.get_top_definition(params[:term])

  unless valid_response? definition
    raise NoDefinition, params[:term]
  end

  jsonp definition
end

#
# Search for Definitions
#
get '/search/:term' do
  definitions = ud.get_definitions(params[:term])

  jsonp definitions
end

#
# Error Handling
#
not_found do
  {:message => 'Route not found. Check your syntax.'}.to_json
end

error NoDefinition do
  status 404

  {:message => "No definitions could be found for: #{env['sinatra.error'].message}"}.to_json
end

error 400 do
  {:message => "Something was wrong with your request: #{env['sinatra.error']}"}.to_json
end

error 500 do
  {:message => 'Something went wrong along the way. It was logged to be looked at.'}.to_json
end

error do
  {:message => 'An unknown error occurred. Check the docs for help.'}.to_json
end
