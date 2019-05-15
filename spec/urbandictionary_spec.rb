require File.expand_path "../spec_helper.rb", __FILE__

RSpec.describe UrbanDictionary do
  describe "#get_top_definition" do
    it "can fetch the top definition" do
      VCR.use_cassette("define") do
        definition = ud.get_top_definition("zomg")

        expect(definition[:id]).to eq("1401399")
        expect(definition[:term]).to eq("zomg")
        expect(definition[:url]).to eq(
          "https://www.urbandictionary.com/define.php?term=zomg&defid=1401399",
        )
        expect(definition[:definition]).to start_with(
          "zOMG is a varient of the all-too-popular acronym",
        )
        expect(definition[:example]).to eq(
          "\"zOMG! you r teh winz!!one!!eleven!\"",
        )
        expect(definition[:author]).to eq("ectweak")
        expect(definition[:author_url]).to eq(
          "https://www.urbandictionary.com/author.php?author=ectweak",
        )
        expect(definition[:posted]).to eq(DateTime.new(2005, 8, 6))
      end
    end

    it "can gracefully handle a bad request" do
      VCR.use_cassette("bad_definition_request") do
        definition = ud.get_top_definition("thvbqgfbhkrvjv")

        expect(definition[:definition]).to be_nil
      end
    end
  end

  describe "#get_definitions" do
    it "can fetch a list of definitions" do
      VCR.use_cassette("define") do
        definitions = ud.get_definitions("zomg")
        definition = definitions.first

        expect(definition[:id]).to eq("1401399")
        expect(definition[:term]).to eq("zomg")
      end
    end

    it "can gracefully handle a bad request" do
      VCR.use_cassette("bad_definition_request") do
        definitions = ud.get_definitions("thvbqgfbhkrvjv")

        expect(definitions).to be_empty
      end
    end
  end

  def ud
    described_class.new
  end
end
