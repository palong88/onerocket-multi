require 'test_helper'

class TeamControllerTest < ActionController::TestCase
  test "should get scaffold" do
    get :scaffold
    assert_response :success
  end

end
