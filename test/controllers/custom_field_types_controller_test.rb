require 'test_helper'

class CustomFieldTypesControllerTest < ActionController::TestCase
  setup do
    @custom_field_type = custom_field_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:custom_field_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create custom_field_type" do
    assert_difference('CustomFieldType.count') do
      post :create, custom_field_type: { custom_field_id: @custom_field_type.custom_field_id, description: @custom_field_type.description, name: @custom_field_type.name }
    end

    assert_redirected_to custom_field_type_path(assigns(:custom_field_type))
  end

  test "should show custom_field_type" do
    get :show, id: @custom_field_type
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @custom_field_type
    assert_response :success
  end

  test "should update custom_field_type" do
    patch :update, id: @custom_field_type, custom_field_type: { custom_field_id: @custom_field_type.custom_field_id, description: @custom_field_type.description, name: @custom_field_type.name }
    assert_redirected_to custom_field_type_path(assigns(:custom_field_type))
  end

  test "should destroy custom_field_type" do
    assert_difference('CustomFieldType.count', -1) do
      delete :destroy, id: @custom_field_type
    end

    assert_redirected_to custom_field_types_path
  end
end
