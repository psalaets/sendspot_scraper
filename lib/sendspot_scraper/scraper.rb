require 'uri'
require 'date'

module SendspotScraper
  class Scraper
    # Hook invoked to figure out if a route has been seen before. Proc is passed
    # sendspot's route id and should return true if already seen, false if not.
    attr_writer :route_exists_hook
    # Hook invoked when a new route is found. Proc is passed the a
    # SendspotScrape::Route.
    attr_writer :new_route_hook
    # Hook invoked when there is an error during scraping. Proc is passed the
    # relevant Error.
    attr_writer :scrape_error_hook

    # Helper that pulls route metadata from route search results html.
    attr_writer :search_results_extractor
    # Helper that pulls route details from route detail page html.
    attr_writer :route_extractor

    def initialize(client)
      @client = client

      @route_exists_hook = lambda {|id| false}
      @new_route_hook = lambda {|r|}
      @scrape_error_hook = lambda {|e|}
    end

    def scrape(days_old = 7)
      search_results_html = @client.recent_routes(days_old)
      hrefs = search_results_extractor.extract(search_results_html)

      hrefs.each do |href|
        id = @client.id_from_route_url(href)
        unless route_exists(id)
          route_details_html = @client.route_details(id)
          route = route_extractor.extract(route_details_html)

          new_route(route)
        end
      end

    rescue DataExtractionError => e
      scrape_error(e)
    end

    def search_results_extractor
      @search_results_extractor ||= SearchResultsExtractor.new
    end

    def route_extractor
      @route_extractor ||= RouteExtractor.new
    end

    private

    def route_exists(id)
      @route_exists_hook.call(id)
    end

    def new_route(route)
      @new_route_hook.call(route)
    end

    def scrape_error(error)
      @scrape_error_hook.call(error)
    end
  end
end