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

      route = Route.new
      route.name = extract_name(html)
      route.grade = extract_grade(html)
      route
    end

    private

    def extract_name(html)
      text_nodes = html.xpath('//tr[@id="body"]/td[1]/p[1]/strong[1]/child::text()')
      text = text_nodes.map(&:text).join

      text.split('-').first.strip
    end

    def extract_grade(html)
      text_nodes = html.xpath('//tr[@id="body"]/td[1]/p[1]/strong[1]/child::text()')
      text = text_nodes.map(&:text).join

      text.split('-').last.strip
    end
  end
end