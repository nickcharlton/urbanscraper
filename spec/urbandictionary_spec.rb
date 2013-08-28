require File.expand_path 'spec_helper.rb', __dir__

describe 'UrbanDictionary' do
  before do
    VCR.insert_cassette name

    @ud = UrbanDictionary.new
  end

  after do
    VCR.eject_cassette
  end
end
