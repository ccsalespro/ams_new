require 'test_helper'

class MerchantsControllerTest < ActionController::TestCase
  setup do
    @merchant = merchants(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:merchants)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create merchant" do
    assert_difference('Merchant.count') do
      post :create, merchant: { amex_per_item: @merchant.amex_per_item, amex_percentage: @merchant.amex_percentage, amex_transactions: @merchant.amex_transactions, amex_vol: @merchant.amex_vol, avg_ticket: @merchant.avg_ticket, business_type_primary: @merchant.business_type_primary, business_type_secondary: @merchant.business_type_secondary, check_card_percentage: @merchant.check_card_percentage, check_card_vol: @merchant.check_card_vol, debit_network_fees: @merchant.debit_network_fees, debit_transactions: @merchant.debit_transactions, debit_vol: @merchant.debit_vol, disc_vol: @merchant.disc_vol, ebt_fees: @merchant.ebt_fees, ebt_vol: @merchant.ebt_vol, interchange_fees: @merchant.interchange_fees, interchange_percentage: @merchant.interchange_percentage, mc_vol: @merchant.mc_vol, sic_1: @merchant.sic_1, sic_2: @merchant.sic_2, sic_3: @merchant.sic_3, total_fees: @merchant.total_fees, total_transactions: @merchant.total_transactions, vs_vol: @merchant.vs_vol }
    end

    assert_redirected_to merchant_path(assigns(:merchant))
  end

  test "should show merchant" do
    get :show, id: @merchant
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @merchant
    assert_response :success
  end

  test "should update merchant" do
    patch :update, id: @merchant, merchant: { amex_per_item: @merchant.amex_per_item, amex_percentage: @merchant.amex_percentage, amex_transactions: @merchant.amex_transactions, amex_vol: @merchant.amex_vol, avg_ticket: @merchant.avg_ticket, business_type_primary: @merchant.business_type_primary, business_type_secondary: @merchant.business_type_secondary, check_card_percentage: @merchant.check_card_percentage, check_card_vol: @merchant.check_card_vol, debit_network_fees: @merchant.debit_network_fees, debit_transactions: @merchant.debit_transactions, debit_vol: @merchant.debit_vol, disc_vol: @merchant.disc_vol, ebt_fees: @merchant.ebt_fees, ebt_vol: @merchant.ebt_vol, interchange_fees: @merchant.interchange_fees, interchange_percentage: @merchant.interchange_percentage, mc_vol: @merchant.mc_vol, sic_1: @merchant.sic_1, sic_2: @merchant.sic_2, sic_3: @merchant.sic_3, total_fees: @merchant.total_fees, total_transactions: @merchant.total_transactions, vs_vol: @merchant.vs_vol }
    assert_redirected_to merchant_path(assigns(:merchant))
  end

  test "should destroy merchant" do
    assert_difference('Merchant.count', -1) do
      delete :destroy, id: @merchant
    end

    assert_redirected_to merchants_path
  end
end
