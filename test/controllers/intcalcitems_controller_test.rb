require 'test_helper'

class IntcalcitemsControllerTest < ActionController::TestCase
  setup do
    @intcalcitem = intcalcitems(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:intcalcitems)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create intcalcitem" do
    assert_difference('Intcalcitem.count') do
      post :create, intcalcitem: { inttype_id: @intcalcitem.inttype_id, transactions: @intcalcitem.transactions, volume: @intcalcitem.volume }
    end

    assert_redirected_to intcalcitem_path(assigns(:intcalcitem))
  end

  test "should show intcalcitem" do
    get :show, id: @intcalcitem
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @intcalcitem
    assert_response :success
  end

  test "should update intcalcitem" do
    patch :update, id: @intcalcitem, intcalcitem: { inttype_id: @intcalcitem.inttype_id, transactions: @intcalcitem.transactions, volume: @intcalcitem.volume }
    assert_redirected_to intcalcitem_path(assigns(:intcalcitem))
  end

  test "should destroy intcalcitem" do
    assert_difference('Intcalcitem.count', -1) do
      delete :destroy, id: @intcalcitem
    end

    assert_redirected_to intcalcitems_path
  end
end
