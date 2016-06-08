require 'test_helper'

class CostsControllerTest < ActionController::TestCase
  setup do
    @cost = costs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:costs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cost" do
    assert_difference('Cost.count') do
      post :create, cost: { business_type: @cost.business_type, high_ticket: @cost.high_ticket, low_ticket: @cost.low_ticket, payment_type: @cost.payment_type, per_item_value: @cost.per_item_value, percentage_value: @cost.percentage_value }
    end

    assert_redirected_to cost_path(assigns(:cost))
  end

  test "should show cost" do
    get :show, id: @cost
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @cost
    assert_response :success
  end

  test "should update cost" do
    patch :update, id: @cost, cost: { business_type: @cost.business_type, high_ticket: @cost.high_ticket, low_ticket: @cost.low_ticket, payment_type: @cost.payment_type, per_item_value: @cost.per_item_value, percentage_value: @cost.percentage_value }
    assert_redirected_to cost_path(assigns(:cost))
  end

  test "should destroy cost" do
    assert_difference('Cost.count', -1) do
      delete :destroy, id: @cost
    end

    assert_redirected_to costs_path
  end
end
