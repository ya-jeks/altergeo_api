require "spec_helper"

describe AltergeoApi::Client do

  before :all do
    login, password = 'test'

    @fixtures_path = "#{File.dirname(__FILE__)}/fixtures"
    @api_url = 'http://altergeo.ru/openapi/v1'
    @auth_api_url = "http://#{login}:#{password}@altergeo.ru/openapi/v1"
    @client = AltergeoApi::Client.new(:email => login, :password => password)
  end

  it "should get types of places" do
    types_of_places = File.read("#@fixtures_path/types_of_places.json")
    stub_request(:any, "#@api_url/types/list").to_return(:body => types_of_places)

    AltergeoApi.types.should be_a AltergeoApi::TypeCollection
  end

  it "should get places by query" do
    places_by_query = File.read("#@fixtures_path/places_by_query.json")
    stub_request(:any, "#@api_url/places/search").to_return(:body => places_by_query)

    AltergeoApi.places(:query => 'Hello').should be_a AltergeoApi::PlaceCollection
  end

  it "should get place by id" do
    place_by_id = File.read("#@fixtures_path/place_by_id.json")
    stub_request(:any, "#@api_url/place/profile").to_return(:body => place_by_id)

    AltergeoApi.place(:place_id => 100).should be_a AltergeoApi::Place
  end

  it "should get nearest places for user by query" do
    places_for_user = File.read("#@fixtures_path/places_for_user.json")
    stub_request(:any, "#@auth_api_url/places/search").to_return(:body => places_for_user)

    @client.places(:query => 'Hello').should be_a AltergeoApi::PlaceCollection
  end

  it "should get place by query with distance" do
    place_with_distance = File.read("#@fixtures_path/place_with_distance.json")
    stub_request(:any, "#@auth_api_url/place/profile").to_return(:body => place_with_distance)

    place = @client.place(:place_id => 100, :lat => 55, :lng => 44)
    place.should be_a AltergeoApi::Place
    place.distance.should > 0
  end

  it "should get user checkins" do
    checkins = File.read("#@fixtures_path/checkins.json")
    stub_request(:any, "#@auth_api_url/user/get_checkins").to_return(:body => checkins)

    @client.checkins.should be_a AltergeoApi::CheckinCollection
  end

  it "should checkin user" do
    checkin = File.read("#@fixtures_path/checkin.json")
    stub_request(:any, "#@auth_api_url/place/checkin").to_return(:body => checkin)

    result = @client.checkin!(:place_id => 100)
    result.should == "ok"
  end
end