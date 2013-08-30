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
# Routes
#


#
# Documentation
#
get '/' do
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
