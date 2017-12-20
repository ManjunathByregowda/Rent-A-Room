require 'test_helper'

class AjaxControllerTest < ActionController::TestCase
  test "should get low_to_high" do
    get :low_to_high
    assert_response :success
  end

  test "should get ligh_to_low" do
    get :ligh_to_low
    assert_response :success
  end

end
