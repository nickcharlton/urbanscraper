require File.expand_path 'spec_helper.rb', __dir__


describe 'UrbanScraper API' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  before do
    VCR.insert_cassette name
  end

  after do
    VCR.eject_cassette
  end

  it 'shows a long README as the homepage' do
    get '/'

    last_response.body.must_include 'UrbanScraper implements a simple API ' +
                                    'for accessing <a href="http://urbandictionary.com/">Urban Dictionary</a>.'
  end

  it 'provides a method to define a term using json' do
    get '/define/zomg'

    last_response.body.must_match(/definition(\\"|")?:(\\"|")?zOMG is a varient/)
  end

  it 'provides a method to define a term using a jsonp callback' do
    get '/define/zomg?callback=functionA'

    last_response.body.must_match(/^functionA\({/)
  end
end

