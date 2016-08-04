require 'test_helper'

class SubscribetocoursesControllerTest < ActionController::TestCase
  setup do
    @subscribetocourse = subscribetocourses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:subscribetocourses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create subscribetocourse" do
    assert_difference('Subscribetocourse.count') do
      post :create, subscribetocourse: {  }
    end

    assert_redirected_to subscribetocourse_path(assigns(:subscribetocourse))
  end

  test "should show subscribetocourse" do
    get :show, id: @subscribetocourse
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @subscribetocourse
    assert_response :success
  end

  test "should update subscribetocourse" do
    patch :update, id: @subscribetocourse, subscribetocourse: {  }
    assert_redirected_to subscribetocourse_path(assigns(:subscribetocourse))
  end

  test "should destroy subscribetocourse" do
    assert_difference('Subscribetocourse.count', -1) do
      delete :destroy, id: @subscribetocourse
    end

    assert_redirected_to subscribetocourses_path
  end
end
