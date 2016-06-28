require "administrate/base_dashboard"

class CostDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    statements: Field::HasMany,
    id: Field::Number,
    business_type: Field::String,
    payment_type: Field::String,
    low_ticket: Field::String.with_options(searchable: false),
    high_ticket: Field::String.with_options(searchable: false),
    per_item_value: Field::String.with_options(searchable: false),
    percentage_value: Field::String.with_options(searchable: false),
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :statements,
    :id,
    :business_type,
    :payment_type,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :statements,
    :id,
    :business_type,
    :payment_type,
    :low_ticket,
    :high_ticket,
    :per_item_value,
    :percentage_value,
    :created_at,
    :updated_at,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :statements,
    :business_type,
    :payment_type,
    :low_ticket,
    :high_ticket,
    :per_item_value,
    :percentage_value,
  ].freeze

  # Overwrite this method to customize how costs are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(cost)
  #   "Cost ##{cost.id}"
  # end
end
