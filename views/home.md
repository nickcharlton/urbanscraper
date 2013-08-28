<h1>UrbanScraper <span class="smallcaps">an API for Urban Dictionary</span></h1>

UrbanScraper implements a simple API for accessing [Urban Dictionary][]. [Nick 
Charlton][] built this to get definitions through [Alfred][].

_**Note:** This was built because Urban Dictionary don't have their own API. To make 
it work, this relies on screen scraping. If you don't get a result when you should, 
something has probably changed._ 

## Methods

The possible methods are below. Currently you can only get the first definition 
of a word.

### Route

```
GET /define/term.json
```

### Response

```json
{
   "timestamp":1319831727,
   "word":"zomg",
   "url":"http://www.urbandictionary.com/define.php?term=zomg",
   "definition":"zOMG is a varient of the all-too-popular acronym \"OMG\"",
   "status":200
}
```

### Description

Returns the definition of a given term. Returns a status code of 404 if the term is 
invalid. The order of the JSON isn't guaranteed. The timestamp represents when it 
was last fetched.

## Usage/Copyright/License

The code is up on [GitHub][]. It's MIT licensed. And, it's hosted on [Heroku][].

The content is owned by those who submitted it to Urban Dictionary. Using this 
(presumably) puts you under the [Urban Dictionary Terms of Service][tos].

A little bit of caching is done on my side to keep the hits to Urban Dictionary 
down, but even then, please don't abuse it. They probably wouldn't like it.

[Urban Dictionary]: http://urbandictionary.com/
[Nick Charlton]: http://nickcharlton.net/
[Alfred]: http://alfredapp.com/
[GitHub]: https://github.com/nickcharlton/urbanscraper
[Heroku]: http://heroku.com/
[tos]: http://www.urbandictionary.com/tos.php
