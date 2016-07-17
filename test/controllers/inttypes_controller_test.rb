require 'test_helper'

class InttypesControllerTest < ActionController::TestCase
  setup do
    @inttype = inttypes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:inttypes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create inttype" do
    assert_difference('Inttype.count') do
      post :create, inttype: { card_type: @inttype.card_type, description: @inttype.description, max: @inttype.max, per_item: @inttype.per_item, percent: @inttype.percent }
    end

    assert_redirected_to inttype_path(assigns(:inttype))
  end

  test "should show inttype" do
    get :show, id: @inttype
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @inttype
    assert_response :success
  end

  test "should update inttype" do
    patch :update, id: @inttype, inttype: { card_type: @inttype.card_type, description: @inttype.description, max: @inttype.max, per_item: @inttype.per_item, percent: @inttype.percent }
    assert_redirected_to inttype_path(assigns(:inttype))
  end

  test "should destroy inttype" do
    assert_difference('Inttype.count', -1) do
      delete :destroy, id: @inttype
    end

    assert_redirected_to inttypes_path
  end
end
