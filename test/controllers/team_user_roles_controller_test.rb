require 'test_helper'

class TeamUserRolesControllerTest < ActionController::TestCase
  setup do
    @team_user_role = team_user_roles(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:team_user_roles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create team_user_role" do
    assert_difference('TeamUserRole.count') do
      post :create, team_user_role: { bill_to: @team_user_role.bill_to, description: @team_user_role.description, name: @team_user_role.name }
    end

    assert_redirected_to team_user_role_path(assigns(:team_user_role))
  end

  test "should show team_user_role" do
    get :show, id: @team_user_role
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @team_user_role
    assert_response :success
  end

  test "should update team_user_role" do
    patch :update, id: @team_user_role, team_user_role: { bill_to: @team_user_role.bill_to, description: @team_user_role.description, name: @team_user_role.name }
    assert_redirected_to team_user_role_path(assigns(:team_user_role))
  end

  test "should destroy team_user_role" do
    assert_difference('TeamUserRole.count', -1) do
      delete :destroy, id: @team_user_role
    end

    assert_redirected_to team_user_roles_path
  end
end
