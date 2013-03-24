require 'open-uri'

module SendspotScraper
  # Sendspot client that retrieves html.
  class Client
    # Public: Create a new client.
    #
    # gym         - Gym name as abbreviated by send spot, e.g. 'earthtreks'.
    # location_id - Location id typically used by send spot as 'gid', e.g. 1.
    def initialize(gym, location_id)
      @gym = gym
      @location_id = location_id
    end

    # Public: Gets html of routes search page.
    #
    # days_old - How many days worth of routes to include in html.
    #
    # Returns String of route search page html, newest routes first.
    def recent_routes(days_old)
      recent_routes_uri(days_old).read
    end

    # Public: Gets html of route details page.
    #
    # id - Route id to get details of.
    #
    # Returns String of route details html.
    def route_details(id)
      route_uri(id).read
    end

    def route_url(id)
      route_uri(id).to_s
    end

    def id_from_route_url(url)
      query_string = URI(url).query

      pairs = {}
      query_string.split('&').each do |pair|
        name, value = pair.split('=')
        pairs[name] = value
      end
      pairs['rid']
    end

    private

    def recent_routes_uri(days_old)
      date_range = {
        :start_date => (Date.today - days_old).to_s,
        :end_date => Date.today.to_s
      }

      query_string = route_search_query_string(date_range)
      URI("#{base_url}routes?#{query_string}")
    end

    def route_search_query_string(params = {})
      defaults = {
        :searching    => 1,
        :string       => '',
        :rt_lead      => 'on',
        :rt_toprope   => 'on',
        :rt_boulder   => 'on',
        :start_grade  => 0,
        :end_grade    => 0,
        :gym          => @location_id,
        :setter       => 0,
        # Sort by set date, newest first
        :sort_by      => 'dateup',
        :sort_order   => 'descending'
      }

      query = defaults.merge(params)
      query.map { |k, v| "#{k}=#{v}" }.join('&')
    end

    def route_uri(id)
      URI("#{base_url}route?rid=#{id}")
    end

    def base_url
      "https://secure.thesendspot.com/#{@gym}/"
    end
  end
end