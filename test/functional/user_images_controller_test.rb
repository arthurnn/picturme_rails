require 'test_helper'

class UserImagesControllerTest < ActionController::TestCase
  setup do
    @user_image = user_images(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:user_images)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user_image" do
    assert_difference('UserImage.count') do
      post :create, user_image: @user_image.attributes
    end

    assert_redirected_to user_image_path(assigns(:user_image))
  end

  test "should show user_image" do
    get :show, id: @user_image.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user_image.to_param
    assert_response :success
  end

  test "should update user_image" do
    put :update, id: @user_image.to_param, user_image: @user_image.attributes
    assert_redirected_to user_image_path(assigns(:user_image))
  end

  test "should destroy user_image" do
    assert_difference('UserImage.count', -1) do
      delete :destroy, id: @user_image.to_param
    end

    assert_redirected_to user_images_path
  end
end
