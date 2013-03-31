require 'spec_helper'

module SendspotScraper
  describe Client do
    it "should require :gym" do
      expect { Client.new(:location_id => 5) }.to raise_error(ArgumentError)
    end

    it "should require :location_id" do
      expect { Client.new(:gym => 'blah') }.to raise_error(ArgumentError)
    end

    it "should generate route url from route id" do
      client = Client.new(:gym => 'gym', :location_id => 5)

      url = client.route_url('20')

      url.should eq('https://secure.thesendspot.com/gym/route?rid=20')
    end

    it "should pull route id from full route url" do
      client = Client.new(:gym => 'gym', :location_id => 5)

      id = client.id_from_route_url('https://secure.thesendspot.com/gym/route?rid=20')

      id.should eq('20')
    end

    it "should pull route id from relative route url" do
      client = Client.new(:gym => 'gym', :location_id => 5)

      id = client.id_from_route_url('./route?rid=21')

      id.should eq('21')
    end
  end
end