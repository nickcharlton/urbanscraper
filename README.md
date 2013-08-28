# urbanscraper

[![Build Status](https://secure.travis-ci.org/nickcharlton/urbanscraper.png?branch=master)](http://travis-ci.org/nickcharlton/urbanscraper)

[Urban Dictionary][] is great. But, it's missing an API. So, this provides one.

This was [originally built to provide a data source for a an extension to the Mac
quick launch tool][post], [Alfred][]. It allowed you to request a definition which
would then be returned back to you. Alfred 2 changed the way extensions worked, and 
so UrbanScraper gained a few new methods, allowing the workflow to give 'live'
results.

The [live version][] is hosted on [Heroku][]. It's a simple [Sinatra][] application, 
using [Nokogiri][] for HTML/XML parsing. [MiniTest][] and [VCR][] are used for
testing and mocking web requests respectively.

## Usage

It is targeted against Ruby 2.0. You'll also need [Bundler][].

```bash
bundle install
bundle exec ruby app.rb
```

Tests can be run using `rake`:

```bash
rake test
```

## License

Copyright (c) 2011 Nick Charlton. Code under the MIT license.

The content you access is under the conditions of the Urban Dictionary's 
[Terms of Service][tos] and owned by those who submitted it.

[Urban Dictionary]: http://www.urbandictionary.com/
[post]: http://nickcharlton.net/posts/introducing-urbanscraper.html
[Alfred]: http://www.alfredapp.com
[live version]: http://urbanscraper.herokuapp.com/
[Heroku]: http://heroku.com/
[Sinatra]: http://www.sinatrarb.com/
[Nokogiri]: http://nokogiri.org/
[MiniTest]: https://github.com/seattlerb/minitest
[VCR]: https://github.com/vcr/vcr
[Bundler]: http://bundler.io
[tos]: http://www.urbandictionary.com/tos.php

