require File.expand_path 'spec_helper.rb', __dir__

describe 'UrbanDictionary' do
  before do
    VCR.insert_cassette name

    @ud = UrbanDictionary.new
  end

  after do
    VCR.eject_cassette
  end

  it 'can fetch a definition' do
    definition = @ud.get_top_definition('zomg')

    # check there's a result
    definition.wont_be_empty

    # it should match the commonest first result
    definition.must_match(/zOMG is a varient of the all-too-popular acronym/)
  end
end
