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

    # Returns inner html String of title element.
    def title_text(html)
      raise DataExtractionError.new("title on route details page") unless html.title
      html.title
    end

    # Breaks title text out into fields.
    #
    # title - Inner html of title element
    #
    # Returns Hash of Symbol to String with keys :name, :grade, :gym, :location
    # if fields could be parsed out of title. Empty Hash otherwise.
    def parse_title(title)
      # Capture groups: name, grade, gym, location
      result = /- (.+) \((.+)\) at (.+) (\((.+)\))?/.match(title)

      if result
        {
          :name     => result[1],
          :grade    => result[2],
          :gym      => result[3],
          # Group 4 is wrapper parens around optional location
          # Group 5 is the location with no parens
          :location => result[5]
        }
      else
        raise DataExtractionError.new("title on route details page")
      end
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
      xpath = '//tr[@id="body"]/td[1]/p[1]/strong[2]/a/text()'
      field_from_nodes(html, "route.setter", xpath) do |nodes|
        setter_text = nodes.first.text
        nickname_match = /\((.+)\)/.match(setter_text)

        # Return nickname if there is one or just return name
        (nickname_match && nickname_match[1]) || setter_text.strip
      end
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
      xpath = '//tr[@id="body"]/td[1]/div[@class="main"]/small[1]/p[1]/strong[text()=\'Type:\']/following-sibling::text()'
      field_from_nodes(html, "route.types", xpath) do |nodes|
        types_text = nodes.map(&:text).join.strip
        types_text.split('/').map(&:strip)
      end
    end

    def field_from_nodes(html, field_name, xpath)
      nodes = html.xpath(xpath)
      raise DataExtractionError.new("No nodes found to get #{field_name} by #{xpath}") if nodes.empty?

      field = yield(nodes)
      raise DataExtractionError.new("#{field_name} was empty") if field.empty?
      field
    end
  end
end