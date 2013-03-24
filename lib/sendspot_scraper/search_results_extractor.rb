require 'nokogiri'

module SendspotScraper
  # Extracts route metadata from route search results html.
  class SearchResultsExtractor
    # Public: Pulls route url path from route search results html.
    #
    # html - HTML String of search results page.
    #
    # Returns Array of href values, one per route.
    def extract(html)
      html = Nokogiri::HTML(html)

      # The html contains a <p> around the table but that isn't technically
      # legal and Nokogiri changes it to <p></p><table>...</table>
      send_mode_form(html).xpath('table/tr/td/a[1]').map do |a|
        a[:href]
      end
    end

    private

    # Helper for finding the form with name="sendMode".
    def send_mode_form(html)
      form = html.xpath('//div[@class="main"]/form').first
      raise DataExtractionError.new('form[@name="sendMode"] not found') unless form
      form
    end
  end
end