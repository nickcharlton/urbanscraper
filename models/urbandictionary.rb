require 'nokogiri'
require 'open-uri'
require 'json'
require 'date'

class UrbanDictionary
  VERSION = '2.0pre'
  UA = "UrbanScraper/#{VERSION} (http://urbanscraper.herokuapp.com)"
  DOMAIN = 'http://www.urbandictionary.com'
  URL = "#{DOMAIN}/define.php?term=" 

  def get_top_definition(term)
    definitions = fetch_definitions(term)
    definition = parse_definition(definitions[0])

    definition[:word] = term
    definition
  end

  def get_definitions(term)
    definitions = fetch_definitions(term)

    definitions.map do |m|
      definition = parse_definition(m)

      definition[:word] = term
      definition
    end
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

  def parse_definition(definition)
    # split the identifier
    id = definition.attribute('id').value
    id.sub!(/entry_/, '')
    
    # extract the definition and clean it up
    definition_block = definition.search("div[@class='definition']")
    definition_text = ""
    definition_block.each { |e| definition_text << e.to_str }
    definition_text.strip!

    # extract the example
    example_block = definition.search("div[@class='example']")
    example = example_block.first.content
    example.strip!

    # extract the metadata block
    metadata_block = definition.search("div[@class='greenery']")

    # parse the author
    author_block = metadata_block.search("a[@class='author']")
    author = author_block.children.first.content
    author_url = author_block.attribute('href').value
    author_url = "#{DOMAIN}#{author_url}"

    # post date
    date_string_block = metadata_block.search("span[@class='date']")
    date_string = date_string_block.first.content
    date_string.strip!
    date = DateTime.parse(date_string)

    Hash[
      :id => id, 
      :definition => definition_text, 
      :example => example, 
      :author => author,
      :author_url => author_url,
      :posted => date
    ]
  end
end
