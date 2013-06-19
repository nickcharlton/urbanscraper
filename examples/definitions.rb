# An example of parsing the Urban Dictionary site using Nokogiri and XPath
#
# We fetch a url, parse it and then print out the definition.

require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'pp'

# pull it into nokogiri
doc = Nokogiri::HTML(open('http://www.urbandictionary.com/define.php?term=zomg'))

# run the xpath
entries_block = doc.xpath("/html/body//table[@id='entries']")
definition_group = entries_block.search("div[@class='definition']")

definitions = Array.new
definition_group.each { |e| definitions << e.to_str }

pp definitions

