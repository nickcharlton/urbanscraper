require File.expand_path "../spec_helper.rb", __FILE__

RSpec.describe "App" do
  let(:json_response) { JSON.parse(last_response.body) }

  describe "/" do
    it "renders the documentation as the homepage" do
      get "/"

      expect(last_response.body).to include(
        "UrbanScraper implements a simple API " +
        "for accessing <a href=\"http://urbandictionary.com/\">Urban " +
        "Dictionary</a>.",
      )
    end
  end

  describe "/define" do
    it "can define a term" do
      VCR.use_cassette("define") do
        get "/define/zomg"

        expect(json_response["id"]).to eq("1401399")
        expect(json_response["term"]).to eq("zomg")
        expect(json_response["definition"]).to include("zOMG is a varient")
        expect(json_response["example"]).to eq(
          "\"zOMG! you r teh winz!!one!!eleven!\"",
        )
        expect(json_response["url"]).to eq(
          "https://www.urbandictionary.com/define.php?term=zomg&defid=1401399",
        )
      end
    end

    it "can wrap the response in a jsonp callback" do
      VCR.use_cassette("define") do
        get "/define/zomg?callback=functionA"

        expect(last_response.body).to start_with("functionA({")
      end
    end
  end
end
