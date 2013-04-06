require 'spec_helper'

module SendspotScraper
  describe Scraper do
    before :each do
      # Client stand-in that doesn't return valid xml. The extractor is faked
      # so the xml doesn't matter.
      @client = double('@client')
      @client.stub(:recent_routes) { |days| "search results" }

      @routes_extractor = double('routes extractor')
      @routes_extractor.stub(:extract) do |xml|
        1.upto(2).map do |i|
          route = Route.new
          route.id = "id #{i}"
          route.name = "name #{i}"
          route.url = "url #{i}"
          route
        end
      end

      @scraper = Scraper.new(@client)
      @scraper.routes_extractor = @routes_extractor
    end

    context "when reading Routes from extractor" do
      it "invokes route hook for every Route" do
        routes_seen = []

        @scraper.route_hook = lambda { |r| routes_seen << r }

        @scraper.scrape

        routes_seen.length.should eq(2)
        routes_seen[0].name.should eq('name 1')
        routes_seen[1].name.should eq('name 2')
      end

      it "doesn't invoke route hook any more after it returns false" do
        routes_seen = []

        @scraper.route_hook = lambda do |r|
          routes_seen << r
          false
        end

        @scraper.scrape

        routes_seen.length.should eq(1)
        routes_seen[0].name.should eq('name 1')
      end
    end

    it "should invoke error hook when routes extractor raises error" do
      @routes_extractor.stub(:extract) do |html|
        raise DataExtractionError, "the message"
      end

      error = nil
      @scraper.scrape_error_hook = lambda { |e| error = e }

      @scraper.scrape

      error.message.should eq('the message')
    end

    it "should invoke error hook when client raises error" do
      @client.stub(:recent_routes) do |days|
        raise "the message"
      end

      error = nil
      @scraper.scrape_error_hook = lambda { |e| error = e }

      @scraper.scrape

      error.message.should eq('the message')
    end
  end
end