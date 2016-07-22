require 'test_helper'

class ProcessorusersControllerTest < ActionController::TestCase
  setup do
    @processoruser = processorusers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:processorusers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create processoruser" do
    assert_difference('Processoruser.count') do
      post :create, processoruser: { agentnumber: @processoruser.agentnumber, processor_id: @processoruser.processor_id, user_id: @processoruser.user_id }
    end

    assert_redirected_to processoruser_path(assigns(:processoruser))
  end

  test "should show processoruser" do
    get :show, id: @processoruser
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @processoruser
    assert_response :success
  end

  test "should update processoruser" do
    patch :update, id: @processoruser, processoruser: { agentnumber: @processoruser.agentnumber, processor_id: @processoruser.processor_id, user_id: @processoruser.user_id }
    assert_redirected_to processoruser_path(assigns(:processoruser))
  end

  test "should destroy processoruser" do
    assert_difference('Processoruser.count', -1) do
      delete :destroy, id: @processoruser
    end

    assert_redirected_to processorusers_path
  end
end
