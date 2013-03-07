module SendspotScraper
  class Route
    # URL to route's page at thesendspot.com.
    attr_accessor :url

    # Route name.
    attr_accessor :name

    # Difficulty grade of the route.
    attr_accessor :grade

    # Who set the route.
    attr_accessor :set_by

    # DateTime of when route was recorded (not necessarily set date).
    attr_accessor :created_at

    # What gym the route is at.
    attr_accessor :gym

    # City of the gym the route is at.
    attr_accessor :location

    # Array indicating what type of climbing this allows. Any of:
    # Boulder, Lead, Top Rope
    attr_reader :types

    def initialize
      @types = []
    end
  end
end