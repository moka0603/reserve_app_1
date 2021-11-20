require "test_helper"

class ResersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get resers_index_url
    assert_response :success
  end
end
