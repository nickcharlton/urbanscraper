require 'sinatra'
require 'redcarpet'
require 'pygments'
require 'json'
require 'sinatra/jsonp'

require_relative 'utils/markdown'
require_relative 'models/urbandictionary'

#
# UrbanDictionary Global
#
ud = UrbanDictionary.new

# custom error handling classes
NoDefinition = Class.new(StandardError)

#
# Helpers
#
helpers do
  def time_for(value)
    case value
      when :yesterday then Time.now - 24*60*60
      when :tomorrow  then Time.now + 24*60*60
      else super
    end
  end

  def valid_response?(result)
    definition = result[:definition]
    posted = result[:posted]

    if definition and posted
      return true
    else
      return false
    end
  end
end

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
