require 'test_helper'

class ManageArticlesTest < ActionDispatch::IntegrationTest
	test "add an article" do
		login_as("taro", true)

		get "/admin/articles/new"
		assert_response :success

		post "/admin/articles",
			article: Factory.attributes_for(:article, title: "")
			assert_template "new"
			assert_select "h2", "error occured."

		post "/admin/articles",
			article: Factory.attributes_for(:article, title: "test")
		assert_redirected_to [:admin, assigns[:article]]
		follow_redirect!
		assert_select "h1", "test"
	end
end
