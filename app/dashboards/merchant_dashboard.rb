require "administrate/base_dashboard"

class MerchantDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    business_dba: Field::String,
    data_number: Field::Number,
    business_type_primary: Field::String,
    business_type_secondary: Field::String,
    sic_1: Field::Number,
    sic_2: Field::Number,
    sic_3: Field::Number,
    interchange_percentage: Field::String.with_options(searchable: false),
    avg_ticket: Field::String.with_options(searchable: false),
    amex_percentage: Field::String.with_options(searchable: false),
    amex_per_item: Field::String.with_options(searchable: false),
    check_card_percentage: Field::String.with_options(searchable: false),
    amex_vol: Field::String.with_options(searchable: false),
    check_card_vol: Field::String.with_options(searchable: false),
    mc_vol: Field::String.with_options(searchable: false),
    vs_vol: Field::String.with_options(searchable: false),
    disc_vol: Field::String.with_options(searchable: false),
    debit_vol: Field::String.with_options(searchable: false),
    total_transactions: Field::Number,
    amex_transactions: Field::Number,
    interchange_fees: Field::String.with_options(searchable: false),
    total_fees: Field::String.with_options(searchable: false),
    debit_transactions: Field::Number,
    debit_network_fees: Field::String.with_options(searchable: false),
    ebt_vol: Field::String.with_options(searchable: false),
    ebt_fees: Field::String.with_options(searchable: false),
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :id,
    :business_dba,
    :data_number,
    :business_type_primary,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :id,
    :business_dba,
    :data_number,
    :business_type_primary,
    :business_type_secondary,
    :sic_1,
    :sic_2,
    :sic_3,
    :interchange_percentage,
    :avg_ticket,
    :amex_percentage,
    :amex_per_item,
    :check_card_percentage,
    :amex_vol,
    :check_card_vol,
    :mc_vol,
    :vs_vol,
    :disc_vol,
    :debit_vol,
    :total_transactions,
    :amex_transactions,
    :interchange_fees,
    :total_fees,
    :debit_transactions,
    :debit_network_fees,
    :ebt_vol,
    :ebt_fees,
    :created_at,
    :updated_at,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :business_dba,
    :data_number,
    :business_type_primary,
    :business_type_secondary,
    :sic_1,
    :sic_2,
    :sic_3,
    :interchange_percentage,
    :avg_ticket,
    :amex_percentage,
    :amex_per_item,
    :check_card_percentage,
    :amex_vol,
    :check_card_vol,
    :mc_vol,
    :vs_vol,
    :disc_vol,
    :debit_vol,
    :total_transactions,
    :amex_transactions,
    :interchange_fees,
    :total_fees,
    :debit_transactions,
    :debit_network_fees,
    :ebt_vol,
    :ebt_fees,
  ].freeze

  # Overwrite this method to customize how merchants are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(merchant)
  #   "Merchant ##{merchant.id}"
  # end
end
