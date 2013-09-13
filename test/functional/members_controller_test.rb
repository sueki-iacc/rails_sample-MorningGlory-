require 'test_helper'

class MembersControllerTest < ActionController::TestCase
  test "index" do
  	login_as("Taro")
  	get :index
  	assert_response :success
  end

  test "index_before_login" do
  	assert_raise(ApplicationController::Forbidden){get :index}
  end

end
