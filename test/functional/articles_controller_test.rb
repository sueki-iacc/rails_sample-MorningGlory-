require 'test_helper'

class ArticlesControllerTest < ActionController::TestCase

	test "show" do
		article=Factory(:article, expired_at: nil)
		get :show, id: article
		assert_response :success
	end
end
