require "sendspot_scraper/version"
require "sendspot_scraper/route"
require "sendspot_scraper/routes_extractor"
require "sendspot_scraper/client"
require "sendspot_scraper/scraper"

module SendspotScraper
  # Raised by extractors when given html they cannot handle.
  class DataExtractionError < RuntimeError; end
end