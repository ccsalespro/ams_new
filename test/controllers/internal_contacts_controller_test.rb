require 'test_helper'

class InternalContactsControllerTest < ActionController::TestCase
  setup do
    @internal_contact = internal_contacts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:internal_contacts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create internal_contact" do
    assert_difference('InternalContact.count') do
      post :create, internal_contact: { email_address: @internal_contact.email_address, full_name: @internal_contact.full_name, message: @internal_contact.message, phone_number: @internal_contact.phone_number }
    end

    assert_redirected_to internal_contact_path(assigns(:internal_contact))
  end

  test "should show internal_contact" do
    get :show, id: @internal_contact
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @internal_contact
    assert_response :success
  end

  test "should update internal_contact" do
    patch :update, id: @internal_contact, internal_contact: { email_address: @internal_contact.email_address, full_name: @internal_contact.full_name, message: @internal_contact.message, phone_number: @internal_contact.phone_number }
    assert_redirected_to internal_contact_path(assigns(:internal_contact))
  end

  test "should destroy internal_contact" do
    assert_difference('InternalContact.count', -1) do
      delete :destroy, id: @internal_contact
    end

    assert_redirected_to internal_contacts_path
  end
end
