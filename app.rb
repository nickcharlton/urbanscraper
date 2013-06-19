require 'sinatra'
require 'nokogiri'
require 'open-uri'
require 'json'

# some error handling for later
NoDef = Class.new(StandardError)

# all of the methods used to parse the file
helpers do
  def get_top_definition(term)
    # pull it into nokogiri
    doc = Nokogiri::HTML(open('http://www.urbandictionary.com/define.php?term=' + term))
    
    # run the xpath
    entries_block = doc.xpath("/html/body//table[@id='entries']")
    definition_group = entries_block.search("div[@class='definition']")
    
    definitions = Array.new
    definition_group.each { |e| definitions << e.to_str }

    definitions[0]
  end
end

get '/' do
  erb :home
end

get '/define/:term.json' do
  data = Hash[
    "word" => params[:term], # term requested
    "timestamp" => Time.now.to_i, # the timestamp of the definition
    "status" => 200, # status of the request
    "url" => "http://www.urbandictionary.com/define.php?term=#{params[:term]}" # the url for the word
  ]
  
  data[:definition] = get_top_definition(params[:term])
  
  if data[:definition].empty?
    raise NoDef
  end

  content_type :text
  data.to_json
end

# some error handling
error NoDef do
  Hash['status' => '404', 'message' => 'No definition found'].to_json
end
