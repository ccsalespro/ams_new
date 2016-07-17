require 'test_helper'

class InttableitemsControllerTest < ActionController::TestCase
  setup do
    @inttableitem = inttableitems(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:inttableitems)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create inttableitem" do
    assert_difference('Inttableitem.count') do
      post :create, inttableitem: { inttype_id: @inttableitem.inttype_id, statement_id: @inttableitem.statement_id, transactions: @inttableitem.transactions, volume: @inttableitem.volume }
    end

    assert_redirected_to inttableitem_path(assigns(:inttableitem))
  end

  test "should show inttableitem" do
    get :show, id: @inttableitem
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @inttableitem
    assert_response :success
  end

  test "should update inttableitem" do
    patch :update, id: @inttableitem, inttableitem: { inttype_id: @inttableitem.inttype_id, statement_id: @inttableitem.statement_id, transactions: @inttableitem.transactions, volume: @inttableitem.volume }
    assert_redirected_to inttableitem_path(assigns(:inttableitem))
  end

  test "should destroy inttableitem" do
    assert_difference('Inttableitem.count', -1) do
      delete :destroy, id: @inttableitem
    end

    assert_redirected_to inttableitems_path
  end
end
