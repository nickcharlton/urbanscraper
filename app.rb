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
get '/define/:term.json' do
  data = Hash[
    :word => params[:term], # term requested
    :timestamp => Time.now.to_i, # the timestamp of the definition
    :status => 200, # status of the request
    :url => "http://www.urbandictionary.com/define.php?term=#{params[:term]}" # the url for the word
  ]
  
  data[:definition] = ud.get_top_definition(params[:term])
  
  if data[:definition].empty?
    raise NoDef
  end

  content_type :text
  data.to_json
end

# some error handling
error NoDef do
  Hash[:status => '404', :message => 'No definitions found.'].to_json
end
