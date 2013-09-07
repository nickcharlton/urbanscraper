## 2.0 (unreleased)

* `[x]` Refactors the screenscraping code into a model class.
* `[x]` Adds an outgoing user agent for the screenscraping code.
* `[ ]` Adds tests for the screenscraping class.
* `[x]` Adds Travis for CI.
* `[ ]` Auto-deploy from Travis.
* `[ ]` Adds a route for search for a term.
* `[ ]` Implements caching using Redis to hold onto definitions.
* `[ ]` Implements rate limiting to kirb against abuse.
* `[x]` Improves the error handling.
* `[ ]` Adds HTTP Headers to communicate the rate limiting and caching.
* `[x]` Moves the documentation to Markdown, not HTML.
* `[x]` Huge improvements to the presentation of the API calls and responses.

## 1.1.1 (21st June, 2013)

* Reworks the CSS (now just straight CSS, not LESS).
* Moves to normalize (like other projects).

## 1.1 (19th June, 2013)

* Fixes the screenscraping code, as Urban Dictionary added a site feature.
* Simplifies the Nokogiri code, to make it easier to adjust in future.
* Updates the README.
* Moves from Google Analytics to Gauges tracking for the documentation.
* Updates the dependencies.

## 1.0 (28th October, 2011)

* Initial release.
* Allows you to fetch a definition for a given term.
