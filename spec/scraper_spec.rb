require 'spec_helper'

module SendspotScraper
  describe Scraper do
    before :each do
      # Client stand-in that doesn't return valid html. The extractors are faked
      # so the html doesn't matter.
      @client = double('@client')
      @client.stub(:recent_routes) { |days| "search results" }
      @client.stub(:route_details) { |id| "route details" }
      @client.stub(:id_from_route_url) { |url| "3" }
      @client.stub(:route_url) { |id| "routes/3" }

      @search_results_extractor = double('search_results_extractor')
      @search_results_extractor.stub(:extract) { |html| ['routes/3'] }

      @route_extractor = double('route_extractor')
      @route_extractor.stub(:extract) { |html| Route.new }

      @scraper = Scraper.new(@client)
      @scraper.search_results_extractor = @search_results_extractor
      @scraper.route_extractor = @route_extractor
    end

    context "finds route that doesn't already exist" do
      it "should invoke new route hook" do
        hook_invoked = false

        @scraper.route_exists_hook = lambda { |id| false }
        @scraper.new_route_hook = lambda { |r| hook_invoked = true }

        @scraper.scrape

        hook_invoked.should be_true
      end

      it "should pass new Route to new route hook" do
        route = nil

        @scraper.route_exists_hook = lambda { |id| false }
        @scraper.new_route_hook = lambda { |r| route = r }

        @scraper.scrape

        route.id.should eq('3')
        route.url.should eq('routes/3')
      end
    end

    context "finds route that already exists" do
      it "should not invoke new route hook" do
        invoked_hook = false

        @scraper.route_exists_hook = lambda { |id| true }
        @scraper.new_route_hook = lambda { |r| invoked_hook = true }

        @scraper.scrape

        invoked_hook.should be_false
      end
    end

    it "should invoke error hook when search results extractor raises error" do
      @search_results_extractor.stub(:extract) do |html|
        raise DataExtractionError, "the message"
      end

      error = nil
      @scraper.scrape_error_hook = lambda { |e| error = e }

      @scraper.scrape

      error.message.should eq('the message')
    end

    it "should invoke error hook when route extractor raises error" do
      @route_extractor.stub(:extract) do |html|
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