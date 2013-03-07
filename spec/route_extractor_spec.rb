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

      it("should return route with grade from html") do
        route = @extractor.extract(@html)

        route.grade.should eq('5.10b')
      end

      it("should return route with setter from html") do
        route = @extractor.extract(@html)

        route.set_by.should eq('Ryan Blah')
      end

      it("should return route with gym from html") do
        route = @extractor.extract(@html)

        route.gym.should eq('Rockville')
      end
    end
  end
end