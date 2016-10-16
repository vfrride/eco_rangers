require 'test_helper'

class RangerIconsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @ranger_icon = ranger_icons(:one)
  end

  test "should get index" do
    get ranger_icons_url
    assert_response :success
  end

  test "should get new" do
    get new_ranger_icon_url
    assert_response :success
  end

  test "should create ranger_icon" do
    assert_difference('RangerIcon.count') do
      post ranger_icons_url, params: { ranger_icon: { image_url: @ranger_icon.image_url } }
    end

    assert_redirected_to ranger_icon_url(RangerIcon.last)
  end

  test "should show ranger_icon" do
    get ranger_icon_url(@ranger_icon)
    assert_response :success
  end

  test "should get edit" do
    get edit_ranger_icon_url(@ranger_icon)
    assert_response :success
  end

  test "should update ranger_icon" do
    patch ranger_icon_url(@ranger_icon), params: { ranger_icon: { image_url: @ranger_icon.image_url } }
    assert_redirected_to ranger_icon_url(@ranger_icon)
  end

  test "should destroy ranger_icon" do
    assert_difference('RangerIcon.count', -1) do
      delete ranger_icon_url(@ranger_icon)
    end

    assert_redirected_to ranger_icons_url
  end
end
