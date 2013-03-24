require 'spec_helper'

module SendspotScraper
  describe Scraper do
    before :each do
      # Client stand-in that doesn't return valid html. The extractors are faked
      # so the html doesn't matter.
      client = double('client')
      client.stub(:recent_routes) { |days| "search results" }
      client.stub(:route_details) { |id| "route details" }

      search_results_extractor = double('search_results_extractor')
      search_results_extractor.stub(:extract) do |html|
        [{:href => 'routes/3', :id => '3'}]
      end

      route_extractor = double('route_extractor')
      route_extractor.stub(:extract) { |html| Route.new }

      @scraper = Scraper.new(client)
      @scraper.search_results_extractor = search_results_extractor
      @scraper.route_extractor = route_extractor
    end

    it "invokes new route hook when route doesn't exist" do
      invoked_hook = false

      @scraper.route_exists_hook = lambda { |id| false }
      @scraper.new_route_hook = lambda { |r| invoked_hook = true }

      @scraper.scrape

      invoked_hook.should be_true
    end

    it "doesn't invoke new route hook when route exists" do
      invoked_hook = false

      @scraper.route_exists_hook = lambda { |id| true }
      @scraper.new_route_hook = lambda { |r| invoked_hook = true }

      @scraper.scrape

      invoked_hook.should be_false
    end
  end
end