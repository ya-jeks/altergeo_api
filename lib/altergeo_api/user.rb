module AltergeoApi
  class User < AltergeoApi::Resource
    attr_reader :id, :first_name, :last_name, :image,
                :sex, :birth_date, :about, :lat, :lng,
                :postime, :country, :city, :street, :status_string,
                :checkin_count, :relation

  end
end