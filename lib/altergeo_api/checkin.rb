module AltergeoApi
  class Checkin < AltergeoApi::Resource
    attr_reader :id, :place, :datetime

    def initialize(src)
      super
      @place = AltergeoApi::Place.new src[:place]
      @datetime = Time.new src[:datetime]
    end
  end
end