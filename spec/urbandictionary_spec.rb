require File.expand_path 'spec_helper.rb', __dir__

describe 'UrbanDictionary' do
  before do
    VCR.insert_cassette name

    @ud = UrbanDictionary.new
  end

  after do
    VCR.eject_cassette
  end

  it 'can fetch the top definition' do
    definition = @ud.get_top_definition('zomg')

    # check there's a result
    definition.wont_be_empty

    # should be a hash
    definition.must_be_kind_of Hash

    # it should match the commonest first result
    definition[:definition].must_match(/zOMG is a varient of the all-too-popular acronym/)
  end

  it 'can fetch a list of possible definitions' do
    definitions = @ud.get_definitions('zomg')

    # check there's a result
    definitions.wont_be_empty

    # extract
    definition = definitions.first

    # and test a definition
    definition.must_be_kind_of Hash
    definition[:definition].must_match(/zOMG is a varient of the all-too-popular acronym/)
  end

  it 'can gracefully handle a bad request' do
    definition = @ud.get_top_definition('thvbqgfbhkrvjv')

    # check there's a result
    definition.wont_be_empty

    # it should be a hash
    definition.must_be_kind_of Hash

    # it will look fine, but not contain a result
    defined = definition[:definition]
    defined.must_be_nil
  end
end
