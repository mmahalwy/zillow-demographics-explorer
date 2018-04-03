require 'test_helper'

class ZillowControllerTest < ActionDispatch::IntegrationTest
  test "should get neighborhood" do
    get zillow_neighborhood_url
    assert_response :success
  end

  test "should get demographics" do
    get zillow_demographics_url
    assert_response :success
  end

end
