require 'test_helper'

class PlaceTypesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @place_type = place_types(:one)
  end

  test "should get index" do
    get place_types_url
    assert_response :success
  end

  test "should get new" do
    get new_place_type_url
    assert_response :success
  end

  test "should create place_type" do
    assert_difference('PlaceType.count') do
      post place_types_url, params: { place_type: { description: @place_type.description, img_url: @place_type.img_url, name: @place_type.name, status: @place_type.status } }
    end

    assert_redirected_to place_type_url(PlaceType.last)
  end

  test "should show place_type" do
    get place_type_url(@place_type)
    assert_response :success
  end

  test "should get edit" do
    get edit_place_type_url(@place_type)
    assert_response :success
  end

  test "should update place_type" do
    patch place_type_url(@place_type), params: { place_type: { description: @place_type.description, img_url: @place_type.img_url, name: @place_type.name, status: @place_type.status } }
    assert_redirected_to place_type_url(@place_type)
  end

  test "should destroy place_type" do
    assert_difference('PlaceType.count', -1) do
      delete place_type_url(@place_type)
    end

    assert_redirected_to place_types_url
  end
end
