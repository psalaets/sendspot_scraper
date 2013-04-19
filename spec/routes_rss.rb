module SendspotScraper
  class RoutesRssValues
    ITEMS_BY_TYPE = {
      # Regular boulder problem
      :boulder => %Q{<item>
          <title>Bad Puppy - V7 - Set by Ryan Bigs (RB) at Earth Treks (Rockville)</title>
          <link>https://secure.theSendSpot.com/vc/route?rid=3614</link>
          <description>Boulder Problem at  (Rockville) Set By Ryan Bigs (Blue)</description>
        </item>
      },
      # V Intro boulder problem, grade has a space
      :vintro => %Q{<item>
          <title>The Intro - V Intro - Set by Ryan Bigs (RB) at Earth Treks (Rockville)</title>
          <link>https://secure.theSendSpot.com/vc/route?rid=100</link>
          <description>Boulder Problem at  (Rockville) Set By Ryan Bigs (Blue)</description>
        </item>
      },
      # Lead only
      :lead => %Q{<item>
          <title>Mama Rock Me - 5.10b - Set by Bob Jones (BJ) at Earth Treks (Rockville)</title>
          <link>https://secure.theSendSpot.com/vc/route?rid=3442</link>
          <description>Lead Only at  (Rockville) Set By Bob Jones (Black)</description>
        </item>
      },
      # Top rope only
      :toprope => %Q{<item>
          <title>Skankin' - 5.10a - Set by Ward Buyin (Skilla) at Earth Treks (Rockville)</title>
          <link>https://secure.theSendSpot.com/vc/route?rid=3174</link>
          <description>Top-Rope Only at  (Rockville) Set By Ward Buyin (Bright Yellow)</description>
        </item>
      },
      # Lead and top rope
      :lead_toprope => %Q{<item>
          <title>LIL' Crush - 5.7 - Set by Bob Jones  at Earth Treks (Rockville)</title>
          <link>https://secure.theSendSpot.com/vc/route?rid=3171</link>
          <description>Lead / Top-Rope at  (Rockville) Set By Bob Jones (Yellow)</description>
        </item>
      },
      # Setter has no nickname
      :no_nick => %Q{<item>
          <title>Bad Puppy - V7 - Set by Ryan Bigs  at Earth Treks (Rockville)</title>
          <link>https://secure.theSendSpot.com/vc/route?rid=3614</link>
          <description>Boulder Problem at  (Rockville) Set By Ryan Bigs (Blue)</description>
        </item>
      },
      :vs_name_style => %Q{<item>
          <title>Thing -vs- Other Thing - V7 - Set by Ryan Bigs  at Earth Treks (Rockville)</title>
          <link>https://secure.theSendSpot.com/vc/route?rid=3614</link>
          <description>Boulder Problem at  (Rockville) Set By Ryan Bigs (Blue)</description>
        </item>
      }
    }

    # Takes Array of type symbols, see SendspotScraper::RoutesRssValues::ITEMS_BY_TYPE
    def initialize(item_types)
      @types = item_types
    end

    def items
      @types.map { |t| ITEMS_BY_TYPE[t] }.join
    end

    def the_binding
      binding
    end
  end

  def self.routes_rss(*item_types)
    values = RoutesRssValues.new(item_types.flatten)
    ERB.new(ROUTES_RSS).result(values.the_binding)
  end

  ROUTES_RSS =<<XML
<?xml version="1.0"?>
<rss version="2.0">
    <channel>
        <title>TheSendSpot.com - Route Feed Stream for Earth Treks(Rockville)</title>
        <link>http://secure.thesendspot.com/vc/rss?gids=3&days_old=1</link>
        <description>TheSendSpot.com - Route Feed Stream</description>
        <language>en_us</language>
        <pubDate>Wed, 03 Apr 2013 14:17:32 EDT</pubDate>
        <lastBuildDate>Wed, 03 Apr 2013 14:17:32 EDT</lastBuildDate>
        <docs></docs>
        <managingEditor>support@theSendSpot.com</managingEditor>
        <webMaster>support@theSendSpot.com</webMaster>
        <%= items %>
    </channel>
</rss>
XML
end