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
      route.set_by = extract_setter(html)
      route.location = extract_location(html)
      route.gym = extract_gym(html)
      route.types.push(*extract_types(html))
      route
    end

    private

    def extract_name(html)
      name_grade_text_nodes = html.xpath('//tr[@id="body"]/td[1]/p[1]/strong[1]/child::text()')
      text = name_grade_text_nodes.map(&:text).join

      text.split('-').first.strip
    end

    def extract_grade(html)
      name_grade_text_nodes = html.xpath('//tr[@id="body"]/td[1]/p[1]/strong[1]/child::text()')
      text = name_grade_text_nodes.map(&:text).join

      text.split('-').last.strip
    end

    def extract_setter(html)
      setter_text_nodes = html.xpath('//tr[@id="body"]/td[1]/p[1]/strong[2]/a/text()')
      setter_text = setter_text_nodes.first.text

      setter_text.strip
    end

    def extract_location(html)
      location_text_nodes = html.xpath('//tr[@id="body"]/td[1]/p[2]/a/text()')
      location_text = location_text_nodes.first.text

      /\((\w+)\)/.match(location_text)[1]
    end

    def extract_gym(html)
      gym_text_nodes = html.xpath('//tr[@id="body"]/td[1]/p[2]/a/text()')
      gym_text = gym_text_nodes.first.text

      /(.+)\(/.match(gym_text)[1].strip
    end

    def extract_types(html)
      types_text_nodes = html.xpath('//tr[@id="body"]/td[1]/div[@class="main"]/small[1]/p[1]/strong[1]/following-sibling::text()')
      types_text = types_text_nodes.map(&:text).join

      types_text.split('/').map(&:strip)
    end
  end
end