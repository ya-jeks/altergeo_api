module AltergeoApi
  class Place < AltergeoApi::Resource
    attr_reader :id, :title, :lat, :lng,
                :image, :about, :country, :city,
                :street, :distance, :rating,
                :checkin_count, :rating_vote_count,
                :type, :phones, :major

    def initialize(src)
      super
      @type = AltergeoApi::Type.new src[:type] if src[:type]
      @phones = src[:phones].map{|r| r[:phone] } if src[:phones]
      @major = AltergeoApi::User.new src[:major][:user] if src[:major] && src[:major][:user]
    end

  end
end