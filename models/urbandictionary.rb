require 'nokogiri'
require 'open-uri'
require 'json'
require 'date'

class UrbanDictionary
  VERSION = '2.1'
  UA = "UrbanScraper/#{VERSION} (http://urbanscraper.herokuapp.com)"
  DOMAIN = 'http://www.urbandictionary.com'
  URL = "#{DOMAIN}/define.php?term=" 

  def get_top_definition(term)
    definitions = fetch_definitions(term)

    parse_definition(term, definitions[0])
  end

  def get_definitions(term)
    definitions = fetch_definitions(term)

    definitions.map { |m| parse_definition(term, m) }
  end

  private

  def fetch_definitions(term)
    # pull it into nokogiri
    doc = Nokogiri::HTML(open(URL + term, 'User-Agent' => UA))
    
    # run the xpath
    entries_block = doc.xpath("/html/body//table[@id='entries']")
    definition_group = entries_block.search("td[@class='text']")

    # extract the actual definitions
    definitions = Array.new
    definition_group.each do |e|
      # actual definitions have an id attribute like: "entry_123456".
      id = e.attribute('id')
      if id.value.start_with? "entry_"
        definitions.push e
      end
    end

    definitions
  end

  def parse_definition(term, definition)
    # split the identifier
    begin
      id = definition.attribute('id').value
      id.sub!(/entry_/, '')
    rescue NoMethodError
      id = ""
    end

    # extract the definition and clean it up
    begin
      definition_block = definition.search("div[@class='definition']")
      definition_text = ""
      definition_block.each { |e| definition_text << e.to_str }
      definition_text.strip!
    rescue NoMethodError
      definition_text
    end

    # extract the example
    begin
      example_block = definition.search("div[@class='example']")
      example = example_block.first.content
      example.strip!
    rescue NoMethodError
      example = ""
    end

    # extract the metadata block
    begin
      metadata_block = definition.search("div[@class='greenery']")
    rescue NoMethodError
      metadata_block = nil
    end

    # parse the author
    begin
      author_block = metadata_block.search("a[@class='author']")
      author = author_block.children.first.content
    rescue NoMethodError
      author = ""
    end

    # and author url
    begin
      author_url = author_block.attribute('href').value
      author_url = "#{DOMAIN}#{author_url}"
    rescue NoMethodError
      author_url = ""
    end

    # post date
    begin
      date_string_block = metadata_block.search("span[@class='date']")
      date_string = date_string_block.first.content
      date_string.strip!
      date = DateTime.parse(date_string)
    rescue NoMethodError
      date = nil
    end

    Hash[
      :id => id, 
      :term => term,
      :url => "#{URL}#{term}&defid=#{id}",
      :definition => definition_text, 
      :example => example, 
      :author => author,
      :author_url => author_url,
      :posted => date
    ]
  end
end
