require 'uri'
require 'date'

module SendspotScraper
  class Scraper
    # Hook invoked when a route is found. Proc is passed instances of
    # SendspotScrape::Route, newest first. Return false to stop receiving
    # Routes.
    attr_writer :route_hook
    # Hook invoked when there is an error during scraping. Proc is passed the
    # relevant Error.
    attr_writer :scrape_error_hook

    # Helper that pulls route data from route feed xml.
    attr_writer :routes_extractor

    def initialize(client)
      @client = client

      @route_hook = lambda {|r|}
      @scrape_error_hook = lambda {|e|}
    end

    def scrape(days_old = 7)
      routes_xml = @client.recent_routes(days_old)
      routes = routes_extractor.extract(routes_xml)

      routes.each do |route|
        break if route_found(route) == false
      end
    rescue => e
      scrape_error(e)
    end

    def routes_extractor
      @routes_extractor ||= RoutesExtractor.new
    end

    private

    def route_found(route)
      @route_hook.call(route)
    end

    def scrape_error(error)
      @scrape_error_hook.call(error)
    end
  end
end