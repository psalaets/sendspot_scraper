require 'nokogiri'

module SendspotScraper
  class SearchResultsExtractor
    def extract(html)
      html = Nokogiri::HTML(html)

      # The html contains a <p> around the table but that isn't technically
      # legal and Nokogiri changes it to <p></p><table>...</table>
      send_mode_form(html).xpath('table/tr/td/a[1]').map do |a|
        {
          :id => id_from_href(a[:href]),
          :href => a[:href]
        }
      end
    end

    private

    def send_mode_form(html)
      form = html.xpath('//div[@class="main"]/form').first
      raise DataExtractionError.new('form[@name="sendMode"] not found') unless form
      form
    end

    def id_from_href(href)
      query_string = href.split('?').last
      pairs = query_string.split('&').reduce({}) do |hash, pair|
        name, value = pair.split('=')
        hash[name] = value
        hash
      end
      pairs['rid']
    end
  end
end