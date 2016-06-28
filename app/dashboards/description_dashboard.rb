require "administrate/base_dashboard"

class DescriptionDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    prospects: Field::HasMany,
    id: Field::Number,
    business_type_primary: Field::String,
    business_type_secondary: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    amex_business_type: Field::String,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :prospects,
    :id,
    :business_type_primary,
    :business_type_secondary,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :prospects,
    :id,
    :business_type_primary,
    :business_type_secondary,
    :created_at,
    :updated_at,
    :amex_business_type,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :prospects,
    :business_type_primary,
    :business_type_secondary,
    :amex_business_type,
  ].freeze

  # Overwrite this method to customize how descriptions are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(description)
  #   "Description ##{description.id}"
  # end
end
