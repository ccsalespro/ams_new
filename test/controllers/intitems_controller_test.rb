require 'test_helper'

class IntitemsControllerTest < ActionController::TestCase
  setup do
    @intitem = intitems(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:intitems)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create intitem" do
    assert_difference('Intitem.count') do
      post :create, intitem: { card_type: @intitem.card_type, inttype_id: @intitem.inttype_id, merchant_id: @intitem.merchant_id, mid: @intitem.mid, month: @intitem.month, transactions: @intitem.transactions, volume: @intitem.volume }
    end

    assert_redirected_to intitem_path(assigns(:intitem))
  end

  test "should show intitem" do
    get :show, id: @intitem
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @intitem
    assert_response :success
  end

  test "should update intitem" do
    patch :update, id: @intitem, intitem: { card_type: @intitem.card_type, inttype_id: @intitem.inttype_id, merchant_id: @intitem.merchant_id, mid: @intitem.mid, month: @intitem.month, transactions: @intitem.transactions, volume: @intitem.volume }
    assert_redirected_to intitem_path(assigns(:intitem))
  end

  test "should destroy intitem" do
    assert_difference('Intitem.count', -1) do
      delete :destroy, id: @intitem
    end

    assert_redirected_to intitems_path
  end
end
