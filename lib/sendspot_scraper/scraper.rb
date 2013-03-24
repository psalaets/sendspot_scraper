require 'uri'
require 'open-uri'
require 'date'

module SendspotScraper
  class Scraper
    attr_writer :already_seen_route
    attr_writer :new_route

    def initialize(gym = 'earthtreks', days_old = 7)
      @gym = gym
      @days_old = days_old
      @already_seen_route = lambda {|id| false}
      @new_route = lambda {|r|}
    end

    def recent_routes
      extractor = SearchResultsExtractor.new
      routes_metadata = extractor.extract(recent_routes_url.read)

      routes_metadata.each do |metadata|
        unless @already_seen_route.call(metadata[:id])
          route_details_html = route_url(metadata[:id]).read
          route_extractor = RouteExtractor.new
          route = route_extractor.extract(route_details_html)

          @new_route.call(route)
        end
      end
    end

    private

    def recent_routes_url
      date_range = {
        :start_date => (Date.today - @days_old).to_s,
        :end_date => Date.today.to_s
      }

      URI("#{base_url}routes?#{query_string(date_range)}")
    end

    def query_string(params = {})
      defaults = {
        :searching    => 1,
        :string       => '',
        :rt_lead      => 'on',
        :rt_toprope   => 'on',
        :rt_boulder   => 'on',
        :start_grade  => 0,
        :end_grade    => 0,
        :gym          => 0,
        :setter       => 0,
        :sort_by      => 'dateup',
        :sort_order   => 'descending'
      }

      query = defaults.merge(params)
      query.map { |k, v| "#{k}=#{v}" }.join('&')
    end

    def route_url(id)
      URI("#{base_url}route?rid=#{id}")
    end

    def base_url
      "https://secure.thesendspot.com/#{@gym}/"
    end
  end
end