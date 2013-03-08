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
      extract_route(html)
    end

    private

    def extract_route(html)
      route           = Route.new
      route.name      = extract_name(html)
      route.grade     = extract_grade(html)
      route.set_by    = extract_setter(html)
      route.location  = extract_location(html)
      route.gym       = extract_gym(html)
      route.types.push(*extract_types(html))
      route
    end

    def title_text(html)
      title_node = html.xpath('/html/head/title').first
      title_node.inner_html
    end

    def parse_title(title)
      # Capture groups: name, grade, gym, location
      result = /- (.+) \((.+)\) at (.+) \((.+)\)/.match(title)

      fields = {}

      if result
        fields[:name] = result[1]
        fields[:grade] = result[2]
        fields[:gym] = result[3]
        fields[:location] = result[4]
      end

      fields
    end

    def extract_name(html)
      title = title_text(html)
      parse_title(title)[:name]
    end

    def extract_grade(html)
      title = title_text(html)
      parse_title(title)[:grade]
    end

    def extract_setter(html)
      setter_text_nodes = html.xpath('//tr[@id="body"]/td[1]/p[1]/strong[2]/a/text()')
      ensure_non_empty(setter_text_nodes, 'route.setter')

      setter_text = setter_text_nodes.first.text

      nickname_match = /\((.+)\)/.match(setter_text)

      # Return nickname if there is one or just return name
      (nickname_match && nickname_match[1]) || setter_text.strip
    end

    def extract_location(html)
      title = title_text(html)
      parse_title(title)[:location]
    end

    def extract_gym(html)
      title = title_text(html)
      parse_title(title)[:gym]
    end

    def extract_types(html)
      types_text_nodes = html.xpath('//tr[@id="body"]/td[1]/div[@class="main"]/small[1]/p[1]/strong[1]/following-sibling::text()')
      types_text = types_text_nodes.map(&:text).join

      types_text.split('/').map(&:strip)
    end

    private

    def ensure_non_empty(nodes, field)
      raise DataExtractionError.new(field) if nodes.empty?
      nodes
    end
  end
end