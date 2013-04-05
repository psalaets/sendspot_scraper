require 'spec_helper'

module SendspotScraper
  describe RoutesExtractor do
    before :each do
      @extractor = RoutesExtractor.new
    end

    after :each do
      @extractor = nil
    end

    it "should read name" do
      routes = @extractor.extract(SendspotScraper.routes_rss(:boulder))

      routes.first.name.should eq('Bad Puppy')
    end

    it "should read grade" do
      routes = @extractor.extract(SendspotScraper.routes_rss(:boulder))

      routes.first.grade.should eq('V7')
    end

    it "should read grade with spaces" do
      routes = @extractor.extract(SendspotScraper.routes_rss(:vintro))

      routes.first.grade.should eq('V Intro')
    end

    context "setter has a nick" do
      it "should read setter nick" do
        routes = @extractor.extract(SendspotScraper.routes_rss(:boulder))

        routes.first.set_by.should eq('RB')
      end
    end

    context "setter has no nick" do
      it "should read setter name" do
        routes = @extractor.extract(SendspotScraper.routes_rss(:no_nick))

        routes.first.set_by.should eq('Ryan Bigs')
      end
    end

    it "should read location" do
      routes = @extractor.extract(SendspotScraper.routes_rss(:boulder))

      routes.first.location.should eq('Rockville')
    end

    it "should read gym" do
      routes = @extractor.extract(SendspotScraper.routes_rss(:boulder))

      routes.first.gym.should eq('Earth Treks')
    end

    it "should read url" do
      routes = @extractor.extract(SendspotScraper.routes_rss(:boulder))

      routes.first.url.should eq('https://secure.theSendSpot.com/vc/route?rid=3614')
    end

    it "should read route id" do
      routes = @extractor.extract(SendspotScraper.routes_rss(:boulder))

      routes.first.id.should eq('3614')
    end

    context "when route is for roped climbing" do
      it("should read all climb types") do
        routes = @extractor.extract(SendspotScraper.routes_rss(:lead_toprope))

        Set.new(routes.first.types).should eq(Set.new([:toprope, :lead]))
      end
    end

    context "when route is a bouldering problem" do
      it("should read climb type") do
        routes = @extractor.extract(SendspotScraper.routes_rss(:boulder))

        Set.new(routes.first.types).should eq(Set.new([:boulder]))
      end
    end

    context "when route is lead only" do
      it("should read climb type") do
        routes = @extractor.extract(SendspotScraper.routes_rss(:lead))

        Set.new(routes.first.types).should eq(Set.new([:lead]))
      end
    end

    context "when route is top rope only" do
      it("should read climb type") do
        routes = @extractor.extract(SendspotScraper.routes_rss(:toprope))

        Set.new(routes.first.types).should eq(Set.new([:toprope]))
      end
    end
  end
end