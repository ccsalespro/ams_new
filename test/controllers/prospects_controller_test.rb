require 'test_helper'

class ProspectsControllerTest < ActionController::TestCase
  setup do
    @prospect = prospects(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:prospects)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create prospect" do
    assert_difference('Prospect.count') do
      post :create, prospect: { business_name: @prospect.business_name, contact_name: @prospect.contact_name }
    end

    assert_redirected_to prospect_path(assigns(:prospect))
  end

  test "should show prospect" do
    get :show, id: @prospect
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @prospect
    assert_response :success
  end

  test "should update prospect" do
    patch :update, id: @prospect, prospect: { business_name: @prospect.business_name, contact_name: @prospect.contact_name }
    assert_redirected_to prospect_path(assigns(:prospect))
  end

  test "should destroy prospect" do
    assert_difference('Prospect.count', -1) do
      delete :destroy, id: @prospect
    end

    assert_redirected_to prospects_path
  end
end
