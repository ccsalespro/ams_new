require "administrate/base_dashboard"

class StatementDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    prospect: Field::BelongsTo,
    costs: Field::HasMany,
    id: Field::Number,
    total_fees: Field::String.with_options(searchable: false),
    batches: Field::Number,
    amex_trans: Field::Number,
    amex_vol: Field::String.with_options(searchable: false),
    vmd_trans: Field::Number,
    vmd_vol: Field::String.with_options(searchable: false),
    debit_trans: Field::Number,
    debit_vol: Field::String.with_options(searchable: false),
    interchange: Field::String.with_options(searchable: false),
    statement_month: Field::String,
    avg_ticket: Field::String.with_options(searchable: false),
    vmd_avg_ticket: Field::String.with_options(searchable: false),
    amex_avg_ticket: Field::String.with_options(searchable: false),
    debit_avg_ticket: Field::String.with_options(searchable: false),
    check_card_avg_ticket: Field::String.with_options(searchable: false),
    check_card_trans: Field::String.with_options(searchable: false),
    check_card_vol: Field::String.with_options(searchable: false),
    debit_network_fees: Field::String.with_options(searchable: false),
    check_card_interchange: Field::String.with_options(searchable: false),
    amex_interchange: Field::String.with_options(searchable: false),
    vmd_interchange: Field::String.with_options(searchable: false),
    total_vol: Field::String.with_options(searchable: false),
    business_type: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :prospect,
    :costs,
    :id,
    :total_fees,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :prospect,
    :costs,
    :id,
    :total_fees,
    :batches,
    :amex_trans,
    :amex_vol,
    :vmd_trans,
    :vmd_vol,
    :debit_trans,
    :debit_vol,
    :interchange,
    :statement_month,
    :avg_ticket,
    :vmd_avg_ticket,
    :amex_avg_ticket,
    :debit_avg_ticket,
    :check_card_avg_ticket,
    :check_card_trans,
    :check_card_vol,
    :debit_network_fees,
    :check_card_interchange,
    :amex_interchange,
    :vmd_interchange,
    :total_vol,
    :business_type,
    :created_at,
    :updated_at,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :prospect,
    :costs,
    :total_fees,
    :batches,
    :amex_trans,
    :amex_vol,
    :vmd_trans,
    :vmd_vol,
    :debit_trans,
    :debit_vol,
    :interchange,
    :statement_month,
    :avg_ticket,
    :vmd_avg_ticket,
    :amex_avg_ticket,
    :debit_avg_ticket,
    :check_card_avg_ticket,
    :check_card_trans,
    :check_card_vol,
    :debit_network_fees,
    :check_card_interchange,
    :amex_interchange,
    :vmd_interchange,
    :total_vol,
    :business_type,
  ].freeze

  # Overwrite this method to customize how statements are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(statement)
  #   "Statement ##{statement.id}"
  # end
end
