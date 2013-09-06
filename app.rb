require 'sinatra'
require 'redcarpet'
require 'pygments'
require 'json'

require_relative 'utils/markdown.rb'
require_relative 'models/urbandictionary.rb'

#
# UrbanDictionary Global
#
ud = UrbanDictionary.new

# some error handling for later
NoDef = Class.new(StandardError)

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
end

before do
  # you can always cache until tomorrow
  expires :tomorrow

  # we'll always return json
  content_type :json
end


#
# Routes
#


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
  
  if definition.empty?
    raise NoDef
  end

  definition.to_json
end

# some error handling
error NoDef do
  Hash[:status => '404', :message => 'No definitions found.'].to_json
end
