require 'spec_helper'

module SendspotScraper
  describe Client do
    it "should generate route url from route id" do
      location_id = 5
      client = Client.new('gym', location_id)

      url = client.route_url('20')

      url.should eq('https://secure.thesendspot.com/gym/route?rid=20')
    end

    it "should pull route id from full route url" do
      location_id = 5
      client = Client.new('gym', location_id)

      id = client.id_from_route_url('https://secure.thesendspot.com/gym/route?rid=20')

      id.should eq('20')
    end

    it "should pull route id from relative route url" do
      location_id = 5
      client = Client.new('gym', location_id)

      id = client.id_from_route_url('./route?rid=21')

      id.should eq('21')
    end
  end
end