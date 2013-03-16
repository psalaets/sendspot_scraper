require "sendspot_scraper/version"
require "sendspot_scraper/route"
require "sendspot_scraper/route_extractor"
require "sendspot_scraper/search_results_extractor"

module SendspotScraper
  # Raised by extractors when given html they cannot handle.
  class DataExtractionError < RuntimeError; end
end