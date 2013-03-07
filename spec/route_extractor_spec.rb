require 'spec_helper'

module SendspotScraper
  describe RouteExtractor do
    context "#extract" do
      before :each do
        @extractor = RouteExtractor.new
        @html = ROUTE_DETAILS_HTML
      end

      after :each do
        @extractor = nil
        @html = nil
      end

      it("should return route with name from html") do
        route = @extractor.extract(@html)

        route.name.should eq('Pity The Fool')
      end
    end
  end
end