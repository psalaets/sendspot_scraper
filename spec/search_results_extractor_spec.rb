require 'spec_helper'

module SendspotScraper
  describe SearchResultsExtractor do
    context "#extract" do
      before :each do
        @extractor = SearchResultsExtractor.new
      end

      after :each do
        @extractor = nil
      end

      context "when there are some results" do
        it("should pull route url and ids from html") do
          routes = @extractor.extract(SendspotScraper.search_results_html)

          routes.should eq(['./route?rid=3302', './route?rid=3260'])
        end
      end

      context "when there are no search results" do
        it("should return no routes") do
          routes = @extractor.extract(SendspotScraper.search_results_html(:empty))

          routes.empty?.should be_true
        end
      end

      context "when search results block can't be found" do
        it("should raise DataExtractionError") do
          html = SendspotScraper.search_results_html(:invalid)

          expect { @extractor.extract(html) }.to raise_error(DataExtractionError)
        end
      end
    end
  end
end