require "administrate/base_dashboard"

class ProgramDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    Processor: Field::BelongsTo,
    id: Field::Number,
    processor_id: Field::Number,
    name: Field::String,
    min_volume: Field::String.with_options(searchable: false),
    max_volume: Field::String.with_options(searchable: false),
    up_front_bonus: Field::String.with_options(searchable: false),
    residual_split: Field::String.with_options(searchable: false),
    min_bp_mark_up: Field::String.with_options(searchable: false),
    min_per_item_fee: Field::String.with_options(searchable: false),
    cost_structure: Field::String,
    terminal_type: Field::String,
    terminal_ownership_type: Field::String,
    per_item_cost: Field::String.with_options(searchable: false),
    bin_sponsorship: Field::String.with_options(searchable: false),
    visa_access_per_item: Field::String.with_options(searchable: false),
    visa_access_percentage: Field::String.with_options(searchable: false),
    mc_access_per_item: Field::String.with_options(searchable: false),
    mc_access_percentage: Field::String.with_options(searchable: false),
    disc_access_per_item: Field::String.with_options(searchable: false),
    disc_access_percentage: Field::String.with_options(searchable: false),
    min_monthly_fees: Field::String.with_options(searchable: false),
    monthly_fee_costs: Field::String.with_options(searchable: false),
    monthly_pci_fee: Field::String.with_options(searchable: false),
    monthly_pci_cost: Field::String.with_options(searchable: false),
    annual_pci_fee: Field::String.with_options(searchable: false),
    annual_pci_cost: Field::String.with_options(searchable: false),
    min_pin_debit_per_item_fee: Field::String.with_options(searchable: false),
    pin_debit_per_item_cost: Field::String.with_options(searchable: false),
    monthly_debit_fee_cost: Field::String.with_options(searchable: false),
    min_monthly_debit_fee: Field::String.with_options(searchable: false),
    next_day_funding_monthly_cost: Field::String.with_options(searchable: false),
    next_day_funding_monthly_fee: Field::String.with_options(searchable: false),
    amex_per_item_cost: Field::String.with_options(searchable: false),
    min_amex_per_item_fee: Field::String.with_options(searchable: false),
    amex_bp_cost: Field::String.with_options(searchable: false),
    min_amex_bp_fee: Field::String.with_options(searchable: false),
    application_fee_cost: Field::String.with_options(searchable: false),
    min_application_fee: Field::String.with_options(searchable: false),
    min_per_batch_fee: Field::String.with_options(searchable: false),
    per_batch_cost: Field::String.with_options(searchable: false),
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :Processor,
    :id,
    :processor_id,
    :name,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :Processor,
    :id,
    :processor_id,
    :name,
    :min_volume,
    :max_volume,
    :up_front_bonus,
    :residual_split,
    :min_bp_mark_up,
    :min_per_item_fee,
    :cost_structure,
    :terminal_type,
    :terminal_ownership_type,
    :per_item_cost,
    :bin_sponsorship,
    :visa_access_per_item,
    :visa_access_percentage,
    :mc_access_per_item,
    :mc_access_percentage,
    :disc_access_per_item,
    :disc_access_percentage,
    :min_monthly_fees,
    :monthly_fee_costs,
    :monthly_pci_fee,
    :monthly_pci_cost,
    :annual_pci_fee,
    :annual_pci_cost,
    :min_pin_debit_per_item_fee,
    :pin_debit_per_item_cost,
    :monthly_debit_fee_cost,
    :min_monthly_debit_fee,
    :next_day_funding_monthly_cost,
    :next_day_funding_monthly_fee,
    :amex_per_item_cost,
    :min_amex_per_item_fee,
    :amex_bp_cost,
    :min_amex_bp_fee,
    :application_fee_cost,
    :min_application_fee,
    :min_per_batch_fee,
    :per_batch_cost,
    :created_at,
    :updated_at,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :Processor,
    :processor_id,
    :name,
    :min_volume,
    :max_volume,
    :up_front_bonus,
    :residual_split,
    :min_bp_mark_up,
    :min_per_item_fee,
    :cost_structure,
    :terminal_type,
    :terminal_ownership_type,
    :per_item_cost,
    :bin_sponsorship,
    :visa_access_per_item,
    :visa_access_percentage,
    :mc_access_per_item,
    :mc_access_percentage,
    :disc_access_per_item,
    :disc_access_percentage,
    :min_monthly_fees,
    :monthly_fee_costs,
    :monthly_pci_fee,
    :monthly_pci_cost,
    :annual_pci_fee,
    :annual_pci_cost,
    :min_pin_debit_per_item_fee,
    :pin_debit_per_item_cost,
    :monthly_debit_fee_cost,
    :min_monthly_debit_fee,
    :next_day_funding_monthly_cost,
    :next_day_funding_monthly_fee,
    :amex_per_item_cost,
    :min_amex_per_item_fee,
    :amex_bp_cost,
    :min_amex_bp_fee,
    :application_fee_cost,
    :min_application_fee,
    :min_per_batch_fee,
    :per_batch_cost,
  ].freeze

  # Overwrite this method to customize how programs are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(program)
  #   "Program ##{program.id}"
  # end
end
