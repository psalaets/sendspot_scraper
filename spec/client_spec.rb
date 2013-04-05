require 'spec_helper'

module SendspotScraper
  describe Client do
    it "should require at least one location id" do
      expect { Client.new() }.to raise_error(ArgumentError)
      expect { Client.new([]) }.to raise_error(ArgumentError)
    end
  end
end