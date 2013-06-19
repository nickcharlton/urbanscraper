# UrbanScraper &mdash; screenscraping API for Urban Dictionary

Wouldn't it be awesome to be able to access [Urban Dictionary][] definitions from a 
script? Well, this is all about. This repo holds the code, but you can access the
hosted version on Heroku: http://urbanscraper.herokuapp.com

## History/Implementation

This was originally written to provide the backend for an [Alfred][] extension that
can look up definitions using Urban Dictionary.

When this was started, Urban Dictionary didn't have an API, so this was the solution
to that. They did originally have some sort of API and since they've announced [this
form to petition interest in a new one][form].

This uses a combination of XPath and some regexes to screenscrape the site. It's
implemented in Ruby using the Sinatra microframework.

## License

Copyright Nick Charlton 2011. Code/Design Licensed under the MIT license.

The content you access is under the conditions of the Urban Dictionary's 
[Terms of Service][tos] and owned by those who submitted it. Whilst it's not 
mentioned, they probably wouldn't appreciate heavy scraping.

[Urban Dictionary]: http://www.urbandictionary.com/
[Alfred]: http://www.alfredapp.com
[form]: http://urbandictionary.wufoo.com/forms/api-interest-form/
[tos]: http://www.urbandictionary.com/tos.php

