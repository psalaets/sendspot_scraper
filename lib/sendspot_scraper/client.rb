require 'open-uri'

module SendspotScraper
  # Sendspot client that retrieves route feed xml.
  class Client
    # Public: Create a new client.
    #
    # location_ids - Location ids or Array of location ids to check for new
    #                routes. These should be the ids used in sendspot as 'gid',
    #                e.g. 1. Must contain at least one id.
    def initialize(*location_ids)
      location_ids = location_ids.flatten
      raise ArgumentError.new('at least one location id is required') if location_ids.empty?

      @location_ids = location_ids
    end

    # Public: Gets xml of recent routes xml.
    #
    # Returns String of route rss feed xml, newest routes first.
    def recent_routes
      recent_routes_uri.read
    end

    private

    def recent_routes_uri
      gids = @location_ids.join(',')
      URI("#{rss_url}?gids=#{gids}")
    end

    def rss_url
      "https://secure.thesendspot.com/vc/rss"
    end
  end
end