# An example of parsing the Urban Dictionary site using Nokogiri and XPath
#
# This fetches the example, sometimes present in definitions.

require 'rubygems'
require 'nokogiri'
require 'open-uri'

# pull it into nokogiri
doc = Nokogiri::HTML(open('http://www.urbandictionary.com/define.php?term=zomg'))

# run the xpath
result = doc.xpath("/html[1]/body[1]/div[3]/div[1]/table[1]/tr[1]/td[2]/div[1]/table[1]/tr[2]/td[2]/div[@class='example']/node()")

example = String.new
result.each { |e| example << e }

p example
