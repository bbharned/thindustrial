require 'test_helper'

class CreateCategoriesTest < ActionDispatch::IntegrationTest
	
	def setup
		@user = User.create(firstname: "Brad", lastname: "Harris", email: "bharris@thinmanager.com", company: "ABC Company", street: "123 Main Street", city: "Springfield", state: "OH", zipcode: 12345, phone: "123-456-0987", password: "password", admin: true)
		#@user2 = User.create(firstname: "Bill", lastname: "Smith", email: "bsmith@thinmanager.com", company: "TM Company", street: "123 Main Street", city: "Springfield", state: "OH", zipcode: 12345, phone: "123-456-0987", password: "password", admin: false)
	end

	test "get new category form and create category" do
		sign_in_as(@user, "password")
		get new_category_path 
		assert_template 'categories/new'
		assert_difference 'Category.count', 1 do
			post_via_redirect categories_path, category: {name: "productivity"} 
		end
		assert_template 'categories/index'
		assert_match "productivity", response.body
	end

	test "invalid category submission result in failure" do
		sign_in_as(@user, "password")
		get new_category_path 
		assert_template 'categories/new'
		assert_no_difference 'Category.count' do
			post categories_path, category: {name: " "} 
		end
		assert_template 'categories/new'
		assert_select "h3.panel-title"
		assert_select "div.panel-body"
	end

end