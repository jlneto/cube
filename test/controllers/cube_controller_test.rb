require "test_helper"

class CubeControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get cube_show_url
    assert_response :success
  end

  test "should get initialize" do
    get cube_initialize_url
    assert_response :success
  end

  test "should get solve" do
    get cube_solve_url
    assert_response :success
  end
end
