require 'nokogiri'

module SendspotScraper
  # Pulls route data from route details html.
  class RouteExtractor
    # Public: Extract route information from a block of html.
    #
    # html - String of html
    #
    # Returns Route with fields set by what was in html.
    def extract(html)
      html = Nokogiri::HTML(html)

      name_grade = html.xpath('/html/body/center/table[3]/tr[1]/td[1]/p[1]/strong[1]/child::text()').map(&:text).join.split('-').map(&:strip)
      name = name_grade.first

      route = Route.new
      route.name = name
      route
    end
  end
end