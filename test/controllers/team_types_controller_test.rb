require 'test_helper'

class TeamTypesControllerTest < ActionController::TestCase
  setup do
    @team_type = team_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:team_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create team_type" do
    assert_difference('TeamType.count') do
      post :create, team_type: { description: @team_type.description }
    end

    assert_redirected_to team_type_path(assigns(:team_type))
  end

  test "should show team_type" do
    get :show, id: @team_type
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @team_type
    assert_response :success
  end

  test "should update team_type" do
    patch :update, id: @team_type, team_type: { description: @team_type.description }
    assert_redirected_to team_type_path(assigns(:team_type))
  end

  test "should destroy team_type" do
    assert_difference('TeamType.count', -1) do
      delete :destroy, id: @team_type
    end

    assert_redirected_to team_types_path
  end
end
