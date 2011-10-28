# UrbanScraper - an API wrapper for Urban Dictionary

Wouldn't it be awesome to be able to access Urban Dictionary definitions from a script? Well, this is what this project is for.

Not interested in the code? Go to http://urbanscraper.heroku.com!

## History

I have a terrible memory for abbreviations and acronyms. Especially those used in places like irc. I wanted to be able to find the definitions using Alfred (a keyboard launcher for OS X), but Urban Dictionary didn't have an API.

Apparently, there used to be one (albeit, SOAP) and there are other ways to get data from Urban Dictionary (using the mobile interface), but that seemed worse than screen scraping did.

So, this is exactly what UrbanScraper does. It scrapes the definitions (on demand) from Urban Dictionary and outputs simple JSON for you to use. It uses a mix of XPath and Regexes to acquire the data.

## Implementation / Usage

This is a Sinatra app (so, Ruby), designed to be hosted on Heroku. This is the same version currently running, so you can too push up your own instance.

But: Don't think of this as a good way to implement anything it implements. It was hacked together over two evenings after work.

## License

Copyright Nick Charlton 2011. Code/Design Licensed under the MIT license.

Content held under the [Urban Dictionary Terms of Service](http://www.urbandictionary.com/tos.php) and owned by those who submitted it. Whilst it's not mentioned, they probably wouldn't appreciate heavy scraping.
