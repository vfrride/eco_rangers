require 'test_helper'

class PlacesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @place = places(:one)
  end

  test "should get index" do
    get places_url
    assert_response :success
  end

  test "should get new" do
    get new_place_url
    assert_response :success
  end

  test "should create place" do
    assert_difference('Place.count') do
      post places_url, params: { place: { address1: @place.address1, address2: @place.address2, city: @place.city, country: @place.country, lat: @place.lat, lng: @place.lng, name: @place.name, place: @place.place, place_type_id_id: @place.place_type_id_id, state_code: @place.state_code, zip: @place.zip } }
    end

    assert_redirected_to place_url(Place.last)
  end

  test "should show place" do
    get place_url(@place)
    assert_response :success
  end

  test "should get edit" do
    get edit_place_url(@place)
    assert_response :success
  end

  test "should update place" do
    patch place_url(@place), params: { place: { address1: @place.address1, address2: @place.address2, city: @place.city, country: @place.country, lat: @place.lat, lng: @place.lng, name: @place.name, place: @place.place, place_type_id_id: @place.place_type_id_id, state_code: @place.state_code, zip: @place.zip } }
    assert_redirected_to place_url(@place)
  end

  test "should destroy place" do
    assert_difference('Place.count', -1) do
      delete place_url(@place)
    end

    assert_redirected_to places_url
  end
end
