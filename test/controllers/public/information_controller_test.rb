require "test_helper"

class Public::InformationControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get public_information_show_url
    assert_response :success
  end

  test "should get edit" do
    get public_information_edit_url
    assert_response :success
  end
end
