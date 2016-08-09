require 'test_helper'

class BuycoursesControllerTest < ActionController::TestCase
  setup do
    @buycourse = buycourses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:buycourses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create buycourse" do
    assert_difference('Buycourse.count') do
      post :create, buycourse: {  }
    end

    assert_redirected_to buycourse_path(assigns(:buycourse))
  end

  test "should show buycourse" do
    get :show, id: @buycourse
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @buycourse
    assert_response :success
  end

  test "should update buycourse" do
    patch :update, id: @buycourse, buycourse: {  }
    assert_redirected_to buycourse_path(assigns(:buycourse))
  end

  test "should destroy buycourse" do
    assert_difference('Buycourse.count', -1) do
      delete :destroy, id: @buycourse
    end

    assert_redirected_to buycourses_path
  end
end
