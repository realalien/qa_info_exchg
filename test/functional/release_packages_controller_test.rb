require 'test_helper'

class ReleasePackagesControllerTest < ActionController::TestCase
  setup do
    @release_package = release_packages(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:release_packages)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create release_package" do
    assert_difference('ReleasePackage.count') do
      post :create, :release_package => @release_package.attributes
    end

    assert_redirected_to release_package_path(assigns(:release_package))
  end

  test "should show release_package" do
    get :show, :id => @release_package.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @release_package.to_param
    assert_response :success
  end

  test "should update release_package" do
    put :update, :id => @release_package.to_param, :release_package => @release_package.attributes
    assert_redirected_to release_package_path(assigns(:release_package))
  end

  test "should destroy release_package" do
    assert_difference('ReleasePackage.count', -1) do
      delete :destroy, :id => @release_package.to_param
    end

    assert_redirected_to release_packages_path
  end
end
