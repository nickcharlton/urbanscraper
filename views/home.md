UrbanScraper implements a simple API for accessing [Urban Dictionary][]. [Nick 
Charlton][] built this to get definitions through [Alfred][].

_**Note:** This was built because Urban Dictionary doesn't have their own API. To 
make it work, this relies on screen scraping. If you don't get a result when you 
should, something has probably changed._ 

## Routes

### Get the Top Definition for a Term

Get the top definition for a specified term. `:term` should be encoded according to
[RFC 3986][].

```
GET /define/:term
```

#### Parameters

* None.

#### Response

```headers
Status: 200 OK
```

```json
{
   "id": "1401399",
   "term": "zomg",
   "definition": "zOMG is a varient of the all-too-popular acronym \"OMG\"",
   "example": "\"zOMG! you r teh winz!!one!!eleven!\"",
   "author": "ectweak",
   "author_url": "http://www.urbandictionary.com/author.php?author=ectweak",
   "url": "http://www.urbandictionary.com/define.php?term=zomg&defid=1401399",
   "posted": "2005-08-06T00:00:00+00:00"
}
```

A 404 error will be returned if no definitions can be found (see below).

### Search for Definitions

Return a list of definitions of a term. `:term` should be encoded according to 
[RFC 3986][].

```
GET /search/:term
```

#### Parameters

* None.

#### Response

```headers
Status: 200 OK
```

```json
[{
   "id": "1401399",
   "term": "zomg",
   "definition": "zOMG is a varient of the all-too-popular acronym \"OMG\"",
   "example": "\"zOMG! you r teh winz!!one!!eleven!\"",
   "author": "ectweak",
   "author_url": "http://www.urbandictionary.com/author.php?author=ectweak",
   "url": "http://www.urbandictionary.com/define.php?term=zomg&defid=1401399",
   "posted": "2005-08-06T00:00:00+00:00"
},
{
   "id": "2212015",
   "term": "zomg",
   "definition": "OMG was the ruler of the planet XYRZON until 2451 AD...",
   "example": "ZOMG, i love cupcakes.",
   "author": "WARRIOR MAN",
   "author_url": "http://www.urbandictionary.com/author.php?author=WARRIOR+MAN",
   "url": "http://www.urbandictionary.com/define.php?term=zomg&defid=2212015",
   "posted": "2007-01-22T00:00:00+00:00"
},
...
]
```

Unlike the top definition, search won't return an error if no reponse is found.
Instead, the result will be an empty JSON array. It will return about 7 results, as
this is where Urban Dictionary starts to page them.

## Error Handling

### 404: Not Found

You'll most likely see this if the term you requested wasn't found at all. It'll
look a bit like this:

```headers
Status: 404 Not Found
```

```json
{
    "message": "No definitions could be found for: thvbqgfbhkrvjv."
}
```

If you miss-call a route, this will happen instead:

```headers
Status: 404 Not Found
```

```json
{
    "message": "Route not found. Check your syntax."
}
```

## Usage/Copyright/License

The code is up on [GitHub][]. It's MIT licensed. And, it's hosted on [Heroku][].

The content is owned by those who submitted it to Urban Dictionary. Using this 
(presumably) puts you under the [Urban Dictionary Terms of Service][tos].

A little bit of caching is done on my side to keep the hits to Urban Dictionary 
down, but even then, please don't abuse it. They probably wouldn't like it.

[Urban Dictionary]: http://urbandictionary.com/
[Nick Charlton]: http://nickcharlton.net/
[Alfred]: http://alfredapp.com/
[RFC 3986]: http://tools.ietf.org/html/rfc3986
[contact]: http://nickcharlton.net/about.html
[GitHub]: https://github.com/nickcharlton/urbanscraper
[Heroku]: http://heroku.com/
[tos]: http://www.urbandictionary.com/tos.php
