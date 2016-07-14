require 'test_helper'

class CategoriesControllerTest < ActionController::TestCase
	def setup
		@category = Category.create(name: "productivity")
		@user = User.create(firstname: "Brad", lastname: "Harris", email: "bharris@thinmanager.com", company: "ABC Company", street: "123 Main Street", city: "Springfield", state: "OH", zipcode: 12345, phone: "123-456-0987", password: "password", admin: true)
		@user2 = User.create(firstname: "Bill", lastname: "Smith", email: "bsmith@thinmanager.com", company: "TM Company", street: "123 Main Street", city: "Springfield", state: "OH", zipcode: 12345, phone: "123-456-0987", password: "password", admin: false)
	end
	
	test "should get categories index" do 
		session[:user_id] = @user2.id #non admin logged in
		get :index
		assert_response :success
	end


	test "should get new" do
		session[:user_id] = @user.id #admin logged in
		get :new
		assert_response :success
	end


	test "should get show" do
		session[:user_id] = @user2.id #non admin logged in
		get(:show, {'id' => @category.id})
		assert_response :success
	end

	test "should redirect creat when admin not logged in" do
		session[:user_id] = @user2.id #non admin logged in
		assert_no_difference 'Category.count' do
			post :create, category: { name: "productivity" }
		end
		assert_redirected_to categories_path
	end

end