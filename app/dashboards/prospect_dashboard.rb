require "administrate/base_dashboard"

class ProspectDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    statements: Field::HasMany,
    user: Field::BelongsTo,
    description: Field::BelongsTo,
    id: Field::Number,
    business_name: Field::String,
    contact_name: Field::String,
    phone: Field::String,
    email: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    description_primary: Field::String,
    description_secondary: Field::String,
    amex_business_type: Field::String,
    source_type: Field::String,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :statements,
    :user,
    :description,
    :id,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :statements,
    :user,
    :description,
    :id,
    :business_name,
    :contact_name,
    :phone,
    :email,
    :created_at,
    :updated_at,
    :description_primary,
    :description_secondary,
    :amex_business_type,
    :source_type,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :statements,
    :user,
    :description,
    :business_name,
    :contact_name,
    :phone,
    :email,
    :description_primary,
    :description_secondary,
    :amex_business_type,
    :source_type,
  ].freeze

  # Overwrite this method to customize how prospects are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(prospect)
  #   "Prospect ##{prospect.id}"
  # end
end
