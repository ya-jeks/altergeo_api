module AltergeoApi
  class Client
    include AltergeoApi::Request

    class << self
      def types
        res = new.post('/types/list', {})
        AltergeoApi::TypeCollection.new res[:types]
      end

      def places(opts)
        res = new.post('/places/search', opts)
        AltergeoApi::PlaceCollection.new res[:places]
      end

      def place(opts)
        res = new.post '/place/profile', opts
        AltergeoApi::Place.new res[:place]
      end
    end

    def initialize(opts = {})
      @email, @password = opts[:email], opts[:password] if opts[:email]
      @lat, @lng = opts[:lat], opts[:lng] if opts[:lat] && opts[:lng]
    end

    def places(opts={})
      res = post '/places/search', opts.merge(:order => :distance,
                                              :lat => @lat,
                                              :lng => @lng)
      AltergeoApi::PlaceCollection.new res[:places]
    end

    def place(opts)
      res = post '/place/profile', opts.merge(:lat => @lat,
                                              :lng => @lng)
      AltergeoApi::Place.new res[:place]
    end

    def checked_places(opts={})
      res = post '/user/get_checkin_places/', opts
      AltergeoApi::PlaceCollection.new res[:places]
    end

    def checkins(opts={})
      res = post '/user/get_checkins', opts
      AltergeoApi::CheckinCollection.new res[:checkins]
    end

    def checkin!(opts = {})
      raise ArgumentError, ':place_id missed' if opts[:place_id].nil?
      res = post '/place/checkin', opts
      res[:text] || res[:error]
    end

    def valid?
      place :place_id => 1
      true
    rescue => e
      false
    end

  end
end