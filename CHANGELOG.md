## 2.2: (unreleased)

* Caching of screenscraping requests.
* HTTP headers to communicate the caching (and what a client should do).

## 2.1: (unreleased)

* Addition of Sentry for exception handling.
* Metric collection of terms, API call execution duration.
* Move to urbanscraper.org and self-hosting.

## 2.0.1 (unreleased)

* Fixes to the screenscraping implementation.
* Removes the rate limiting references from the documentation.

## 2.0 (unreleased)

* Refactors the screenscraping code into a model class.
* Adds an outgoing user agent for the screenscraping code.
* Adds tests for the screenscraping class.
* Adds Travis for CI.
* Adds a route for search for a term.
* Improves the error handling.
* Moves the documentation to Markdown, not HTML.
* Huge improvements to the presentation of the API calls and responses.

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
