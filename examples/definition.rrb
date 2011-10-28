# An example of parsing the Urban Dictionary site using Nokogiri and XPath
#
# We fetch a url, parse it and then print out the definition.

require 'rubygems'
require 'nokogiri'
require 'open-uri'

# pull it into nokogiri
doc = Nokogiri::HTML(open('http://www.urbandictionary.com/define.php?term=zomg'))

# run the xpath
result = doc.xpath("/html[1]/body[1]/div[3]/div[1]/table[1]/tr[1]/td[2]/div[1]/table[1]/tr[2]/td[2]/div[@class='definition']/node()")

definition = String.new
result.each { |e| definition << e }

p definition.class
