require 'spec_helper'
require 'set'

module SendspotScraper
  describe RouteExtractor do
    context "#extract" do
      before :each do
        @extractor = RouteExtractor.new
        @fully_populated_html = SendspotScraper.route_details_html
      end

      after :each do
        @extractor = nil
        @fully_populated_html = nil
      end

      context "when all required fields are available in html" do
        it("should pull route name from html") do
          route = @extractor.extract(@fully_populated_html)

          route.name.should eq('Pity The Fool')
        end

        it("should pull grade from html") do
          route = @extractor.extract(@fully_populated_html)

          route.grade.should eq('5.10b')
        end

        context "when setter has nickname" do
          it("should pull setter nick from html") do
            route = @extractor.extract(@fully_populated_html)

            route.set_by.should eq('Ryan B')
          end
        end

        context "when setter doesn't have nickname" do
          it("should pull setter name from html") do
            html = SendspotScraper.route_details_html(:has_setter_nick => false)

            route = @extractor.extract(html)

            route.set_by.should eq('Ryan Blah')
          end
        end

        it("should pull location from html") do
          route = @extractor.extract(@fully_populated_html)

          route.location.should eq('Rockville')
        end

        it("should pull gym from html") do
          route = @extractor.extract(@fully_populated_html)

          route.gym.should eq('Earth Treks')
        end

        it("should pull climb types from html") do
          route = @extractor.extract(@fully_populated_html)

          Set.new(route.types).should eq(Set.new(['Lead', 'Top-Rope']))
        end
      end

      context "when can't find setter in html" do
        it("should raise DataExtractionError") do
          html = SendspotScraper.route_details_html(:has_setter_link => false)

          expect { @extractor.extract(html) }.to raise_error(DataExtractionError, "route.setter")
        end
      end
    end
  end
end