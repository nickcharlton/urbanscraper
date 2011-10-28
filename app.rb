require 'sinatra'
require 'nokogiri'
require 'open-uri'

helpers do
  def get_definition(term)
    # pull it into nokogiri
    doc = Nokogiri::HTML(open('http://www.urbandictionary.com/define.php?term=' + term))
 
    # run the xpath
    result = doc.xpath("/html[1]/body[1]/div[3]/div[1]/table[1]/tr[1]/td[2]/div[1]/table[1]/tr[2]/td[2]/div[@class='definition']/node()")
 
    definition = String.new
    result.each { |e| definition << e }
  
    definition
  end
end

get '/' do
  erb :home
end

get '/define/:term.:format?' do
  definition = get_definition(params[:term])

  case params[:format]
  when 'xml'
    content_type :xml
    definition.to_xml
  when 'json'
    content_type :json
    definition.to_json
  else
    content_type :json
    definition.to_json
  end
end
