require 'test_helper'

class ListCategoriesTest < ActionDispatch::IntegrationTest
	def setup
		@category = Category.create(name: "Productivity")
		@category2 = Category.create(name: "Visualization")
		@user2 = User.create(firstname: "Bill", lastname: "Smith", email: "bsmith@thinmanager.com", company: "TM Company", street: "123 Main Street", city: "Springfield", state: "OH", zipcode: 12345, phone: "123-456-0987", password: "password", admin: false)
	end

	test "should show categories listing"  do
		sign_in_as(@user2, "password")
		get categories_path
		assert_template 'categories/index'
		assert_select "a[href=?]", category_path(@category), text: @category.name
		assert_select "a[href=?]", category_path(@category2), text: @category2.name
	end

end