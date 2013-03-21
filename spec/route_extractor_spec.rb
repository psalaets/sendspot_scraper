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

        context "when route is for roped climbing" do
          it("should pull climb types from html") do
            route = @extractor.extract(@fully_populated_html)

            Set.new(route.types).should eq(Set.new(['Lead', 'Top-Rope']))
          end
        end

        context "when route is a bouldering problem" do
          it("should pull climb type from html") do
            route = @extractor.extract(SendspotScraper.route_details_html(:types => ['Bouldering Problem']))

            Set.new(route.types).should eq(Set.new(['Bouldering Problem']))
          end
        end

        context "when route is lead only" do
          it("should pull climb type from html") do
            route = @extractor.extract(SendspotScraper.route_details_html(:types => ['Lead Only']))

            Set.new(route.types).should eq(Set.new(['Lead Only']))
          end
        end

        context "when route is top rope only" do
          it("should pull climb type from html") do
            route = @extractor.extract(SendspotScraper.route_details_html(:types => ['Top-Rope Only']))

            Set.new(route.types).should eq(Set.new(['Top-Rope Only']))
          end
        end
      end

      context "when can't find setter element in html" do
        it("should raise DataExtractionError") do
          html = SendspotScraper.route_details_html(:has_setter_link => false)

          expect { @extractor.extract(html) }.to raise_error(DataExtractionError)
        end
      end

      context "when route types is blank in html" do
        it("should raise DataExtractionError") do
          html = SendspotScraper.route_details_html(:types => [])

          expect { @extractor.extract(html) }.to raise_error(DataExtractionError)
        end
      end

      context "when can't find route types element in html" do
        it("should raise DataExtractionError") do
          html = SendspotScraper.route_details_html(:has_climb_types_element => false)

          expect { @extractor.extract(html) }.to raise_error(DataExtractionError)
        end
      end

      context "when name is blank in html" do
        it("should raise DataExtractionError") do
          html = SendspotScraper.route_details_html(:name => '')

          expect { @extractor.extract(html) }.to raise_error(DataExtractionError)
        end
      end

      context "when grade is blank in html" do
        it("should raise DataExtractionError") do
          html = SendspotScraper.route_details_html(:grade => '')

          expect { @extractor.extract(html) }.to raise_error(DataExtractionError)
        end
      end

      context "when gym is blank in html" do
        it("should raise DataExtractionError") do
          html = SendspotScraper.route_details_html(:gym => '')

          expect { @extractor.extract(html) }.to raise_error(DataExtractionError)
        end
      end

      context "when location is blank in html" do
        it("should return route with nil location") do
          html = SendspotScraper.route_details_html(:has_location => false)

          route = @extractor.extract(html)

          route.location.should be_nil
        end
      end
    end
  end
end