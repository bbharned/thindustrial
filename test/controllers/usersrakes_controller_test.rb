require 'test_helper'

class UsersrakesControllerTest < ActionController::TestCase
  setup do
    @usersrake = usersrakes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:usersrakes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create usersrake" do
    assert_difference('Usersrake.count') do
      post :create, usersrake: { routes: @usersrake.routes }
    end

    assert_redirected_to usersrake_path(assigns(:usersrake))
  end

  test "should show usersrake" do
    get :show, id: @usersrake
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @usersrake
    assert_response :success
  end

  test "should update usersrake" do
    patch :update, id: @usersrake, usersrake: { routes: @usersrake.routes }
    assert_redirected_to usersrake_path(assigns(:usersrake))
  end

  test "should destroy usersrake" do
    assert_difference('Usersrake.count', -1) do
      delete :destroy, id: @usersrake
    end

    assert_redirected_to usersrakes_path
  end
end
