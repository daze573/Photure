require "test_helper"

class Public::TagsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_tags_index_url
    assert_response :success
  end

  test "should get edit" do
    get public_tags_edit_url
    assert_response :success
  end
end
