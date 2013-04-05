require 'nokogiri'

module SendspotScraper
  # Pulls route data out of sendspot's rss feed.
  class RoutesExtractor
    def extract(rss)
      doc = Nokogiri::XML(rss)

      item = doc.xpath('/rss/channel/item')

      title = item > 'title'
      title_parts = parse_title(title.text)

      route = Route.new
      route.name = title_parts[:name]
      route.grade = title_parts[:grade]
      route.set_by = title_parts[:set_by]
      route.location = title_parts[:location]
      route.gym = title_parts[:gym]

      link = item > 'link'
      link_parts = parse_link(link.text)

      route.id = link_parts[:rid]
      route.url = link_parts[:url]

      [route]
    end

    private

    def parse_title(title)
      front, middle, back = title.split('-')

      {
        :name => front.strip,
        :grade => middle.strip
      }.merge(split_title_back(back))
    end

    def split_title_back(back)
      chunks = back.match(/by (.+) at (.+)/)
      setter_chunk = chunks[1]
      location_chunk = chunks[2]

      {
        :set_by => parse_setter(setter_chunk),
        :location => parse_location(location_chunk),
        :gym => parse_gym(location_chunk)
      }
    end

    def parse_setter(setter_chunk)
      # If chunk contains setter nick
      if matches = setter_chunk.match(/\((.+)\)/)
        # Return setter nick
        matches[1]
      else
        # Otherwise the chunk is setter name
        setter_chunk.strip
      end
    end

    def parse_location(location_chunk)
      location_chunk = location_chunk.strip

      matches = location_chunk.match(/\((.+)\)/)
      matches && matches[1]
    end

    def parse_gym(location_chunk)
      location_chunk = location_chunk.strip

      matches = location_chunk.match(/(.+) \(/)
      matches && matches[1]
    end

    def parse_link(link)
      {
        :url => link,
        :rid => rid_from_route_url(link)
      }
    end

    def rid_from_route_url(url)
      query_string = URI(url).query

      pairs = {}
      query_string.split('&').each do |pair|
        name, value = pair.split('=')
        pairs[name] = value
      end
      pairs['rid']
    end
  end
end