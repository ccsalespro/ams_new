# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180608033736) do

  create_table "cc_fields", force: :cascade do |t|
    t.integer  "comparison_id"
    t.integer  "custom_field_type_id"
    t.string   "name"
    t.decimal  "amount"
    t.decimal  "cost"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "cc_fields", ["comparison_id"], name: "index_cc_fields_on_comparison_id"
  add_index "cc_fields", ["custom_field_type_id"], name: "index_cc_fields_on_custom_field_type_id"

  create_table "chapters", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "course_id"
  end

  add_index "chapters", ["course_id"], name: "index_chapters_on_course_id"

  create_table "chapterusers", force: :cascade do |t|
    t.integer "user_id"
    t.integer "chapter_id"
    t.integer "course_id"
  end

  add_index "chapterusers", ["chapter_id"], name: "index_chapterusers_on_chapter_id"
  add_index "chapterusers", ["course_id"], name: "index_chapterusers_on_course_id"
  add_index "chapterusers", ["user_id"], name: "index_chapterusers_on_user_id"

  create_table "chats", force: :cascade do |t|
    t.string   "message"
    t.integer  "team_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comparisons", force: :cascade do |t|
    t.integer  "statement_id"
    t.integer  "program_id"
    t.decimal  "batch_fees"
    t.decimal  "vs_mark_up_fees"
    t.decimal  "mc_mark_up_fees"
    t.decimal  "ds_mark_up_fees"
    t.decimal  "total_vmd_mark_up_fees"
    t.decimal  "amex_mark_up_fees"
    t.decimal  "vs_trans_fees"
    t.decimal  "mc_trans_fees"
    t.decimal  "ds_trans_fees"
    t.decimal  "total_vmd_trans_fees"
    t.decimal  "amex_trans_fees"
    t.decimal  "vs_access_per_item_fees"
    t.decimal  "mc_access_per_item_fees"
    t.decimal  "ds_access_per_item_fees"
    t.decimal  "vs_access_percentage_fees"
    t.decimal  "mc_access_percentage_fees"
    t.decimal  "ds_access_percentage_fees"
    t.decimal  "total_vmd_access_fees"
    t.decimal  "debit_trans_fees"
    t.decimal  "total_debit_fees"
    t.decimal  "total_program_fees"
    t.decimal  "batch_fee_costs"
    t.decimal  "bin_fee_costs"
    t.decimal  "vs_trans_fee_costs"
    t.decimal  "mc_trans_fee_costs"
    t.decimal  "ds_trans_fee_costs"
    t.decimal  "total_vmd_trans_fee_costs"
    t.decimal  "amex_per_item_costs"
    t.decimal  "amex_mark_up_costs"
    t.decimal  "debit_per_item_costs"
    t.decimal  "total_debit_costs"
    t.decimal  "total_program_costs"
    t.decimal  "total_program_savings"
    t.decimal  "total_program_residuals"
    t.decimal  "total_program_bonus"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.decimal  "total_vs_access_fees"
    t.decimal  "total_mc_access_fees"
    t.decimal  "total_ds_access_fees"
    t.decimal  "monthly_fees"
    t.decimal  "monthly_pci_fees"
    t.decimal  "annual_fee"
    t.decimal  "annual_pci_fees"
    t.decimal  "bp_mark_up"
    t.decimal  "per_item_fee"
    t.decimal  "vs_access_per_item_fee"
    t.decimal  "vs_access_percentage_fee"
    t.decimal  "mc_access_per_item_fee"
    t.decimal  "mc_access_percentage_fee"
    t.decimal  "ds_access_per_item_fee"
    t.decimal  "ds_access_percentage_fee"
    t.decimal  "monthly_pci_fee"
    t.decimal  "annual_pci_fee"
    t.decimal  "pin_debit_per_item_fee"
    t.integer  "pin_debit_bp_mark_up"
    t.decimal  "monthly_debit_fee"
    t.decimal  "next_day_funding_fee"
    t.decimal  "amex_per_item_fee"
    t.integer  "amex_bp_mark_up"
    t.decimal  "application_fee"
    t.decimal  "per_batch_fee"
    t.decimal  "check_card_qual"
    t.decimal  "check_card_midqual"
    t.decimal  "check_card_nonqual"
    t.decimal  "credit_qual"
    t.decimal  "credit_midqual"
    t.decimal  "credit_nonqual"
    t.decimal  "swiped_flat_rate"
    t.decimal  "keyed_flat_rate"
    t.decimal  "tier_check_card_per_item_surcharge"
    t.decimal  "tier_credit_per_item_surcharge"
    t.decimal  "gross_margin_fixed"
    t.decimal  "savings_fixed"
    t.decimal  "amex_per_item_cost"
    t.decimal  "amex_percentage_cost"
    t.decimal  "amex_total_opt_blue"
    t.decimal  "custom_monthly_fees"
    t.decimal  "custom_annual_fees"
    t.decimal  "custom_vmd_per_item_fee"
    t.decimal  "custom_vmd_volume_bp"
    t.decimal  "custom_amex_per_item"
    t.decimal  "custom_amex_volume_bp"
    t.decimal  "custom_pin_per_item"
    t.decimal  "custom_pin_volume_bp"
    t.decimal  "custom_sales_bonus"
    t.decimal  "custom_one_time_fee"
    t.decimal  "custom_total_vmd_per_item_fees"
    t.decimal  "custom_total_vmd_volume_bp_fees"
    t.decimal  "custom_total_amex_per_item_fees"
    t.decimal  "custom_total_amex_volume_bp_fees"
    t.decimal  "custom_total_pin_per_item_fees"
    t.decimal  "custom_total_pin_volume_bp_fees"
    t.decimal  "custom_monthly_fee_costs"
    t.decimal  "custom_annual_fee_costs"
    t.decimal  "custom_vmd_per_item_fee_costs"
    t.decimal  "custom_vmd_volume_bp_costs"
    t.decimal  "custom_amex_per_item_costs"
    t.decimal  "custom_amex_volume_bp_costs"
    t.decimal  "custom_pin_per_item_costs"
    t.decimal  "custom_pin_volume_bp_costs"
    t.decimal  "custom_sales_bonus_costs"
    t.decimal  "custom_one_time_fee_costs"
    t.decimal  "custom_vmd_per_item_fee_cost"
    t.decimal  "custom_vmd_volume_bp_cost"
    t.decimal  "custom_amex_per_item_cost"
    t.decimal  "custom_amex_volume_bp_cost"
    t.decimal  "custom_pin_per_item_cost"
    t.decimal  "custom_pin_volume_bp_cost"
    t.text     "notes"
    t.decimal  "per_item_change"
    t.decimal  "bp_change"
    t.decimal  "change_counter"
    t.decimal  "starting_per_item"
    t.decimal  "starting_bp"
    t.decimal  "surcharge_percentage"
    t.decimal  "total_surcharge_amount"
    t.decimal  "service_fee"
    t.decimal  "service_fees"
    t.decimal  "interchange"
    t.decimal  "debit_network_fees"
    t.decimal  "amex_interchange"
    t.decimal  "ds_fees"
    t.decimal  "mc_fees"
    t.decimal  "vs_fees"
    t.decimal  "debit_bp_mark_up"
    t.decimal  "debit_bp_mark_up_fees"
  end

  add_index "comparisons", ["program_id"], name: "index_comparisons_on_program_id"
  add_index "comparisons", ["statement_id"], name: "index_comparisons_on_statement_id"

  create_table "costs", force: :cascade do |t|
    t.string   "business_type"
    t.string   "payment_type"
    t.decimal  "low_ticket"
    t.decimal  "high_ticket"
    t.decimal  "per_item_value"
    t.decimal  "percentage_value"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "courses", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "courseusers", force: :cascade do |t|
    t.integer "user_id"
    t.integer "course_id"
    t.string  "quiz_score"
  end

  add_index "courseusers", ["course_id"], name: "index_courseusers_on_course_id"
  add_index "courseusers", ["user_id"], name: "index_courseusers_on_user_id"

  create_table "custom_field_types", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "slug_string"
  end

  create_table "custom_fields", force: :cascade do |t|
    t.string   "name"
    t.decimal  "amount"
    t.decimal  "cost"
    t.integer  "program_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "custom_field_type_id"
  end

  add_index "custom_fields", ["custom_field_type_id"], name: "index_custom_fields_on_custom_field_type_id"
  add_index "custom_fields", ["program_id"], name: "index_custom_fields_on_program_id"

  create_table "descriptions", force: :cascade do |t|
    t.string   "business_type_primary"
    t.string   "business_type_secondary"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "amex_business_type"
    t.decimal  "avg_ticket"
  end

  create_table "intcalcitems", force: :cascade do |t|
    t.integer  "inttype_id"
    t.integer  "transactions"
    t.decimal  "volume"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.integer  "statement_id"
    t.integer  "prospect_id"
    t.decimal  "inttype_percent"
    t.integer  "description_id"
    t.decimal  "avg_ticket_variance"
  end

  add_index "intcalcitems", ["inttype_id"], name: "index_intcalcitems_on_inttype_id"
  add_index "intcalcitems", ["prospect_id"], name: "index_intcalcitems_on_prospect_id"
  add_index "intcalcitems", ["statement_id"], name: "index_intcalcitems_on_statement_id"

  create_table "internal_contacts", force: :cascade do |t|
    t.string   "full_name"
    t.string   "phone_number"
    t.string   "email_address"
    t.text     "message"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.boolean  "read",          default: false
  end

  create_table "intitems", force: :cascade do |t|
    t.integer  "merchant_id"
    t.integer  "inttype_id"
    t.integer  "month"
    t.string   "card_type"
    t.integer  "transactions"
    t.decimal  "volume"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "intitems", ["inttype_id"], name: "index_intitems_on_inttype_id"
  add_index "intitems", ["merchant_id"], name: "index_intitems_on_merchant_id"

  create_table "inttableitems", force: :cascade do |t|
    t.integer  "inttype_id"
    t.integer  "statement_id"
    t.decimal  "transactions"
    t.decimal  "volume"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.decimal  "costs"
    t.decimal  "avg_ticket"
    t.string   "inttype_description"
    t.decimal  "inttype_percent"
    t.decimal  "inttype_per_item"
    t.string   "card_type"
  end

  add_index "inttableitems", ["inttype_id"], name: "index_inttableitems_on_inttype_id"
  add_index "inttableitems", ["statement_id"], name: "index_inttableitems_on_statement_id"

  create_table "inttypes", force: :cascade do |t|
    t.string   "card_type"
    t.string   "description"
    t.decimal  "percent"
    t.decimal  "per_item"
    t.decimal  "max"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.boolean  "btob",             default: false
    t.boolean  "btoc",             default: false
    t.boolean  "keyed",            default: false
    t.boolean  "swiped",           default: false
    t.boolean  "ecomm",            default: false
    t.boolean  "cvv",              default: false
    t.boolean  "zip",              default: false
    t.boolean  "address",          default: false
    t.boolean  "name",             default: false
    t.boolean  "downgrade",        default: false
    t.string   "biz_type"
    t.decimal  "max_ticket"
    t.text     "full_description"
    t.boolean  "credit"
    t.boolean  "debit"
    t.boolean  "prepaid"
    t.boolean  "regulated"
    t.boolean  "te"
    t.boolean  "rewards"
    t.string   "tier"
  end

  create_table "lessons", force: :cascade do |t|
    t.string   "title"
    t.string   "video"
    t.integer  "minutes"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "chapter_id"
    t.datetime "completed_at"
    t.text     "description"
    t.integer  "lesson_number"
    t.integer  "course_id"
  end

  add_index "lessons", ["chapter_id"], name: "index_lessons_on_chapter_id"
  add_index "lessons", ["course_id"], name: "index_lessons_on_course_id"

  create_table "lessonusers", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "lesson_id"
    t.integer  "chapter_id"
    t.integer  "course_id"
    t.datetime "completed_at"
  end

  add_index "lessonusers", ["chapter_id"], name: "index_lessonusers_on_chapter_id"
  add_index "lessonusers", ["course_id"], name: "index_lessonusers_on_course_id"
  add_index "lessonusers", ["lesson_id"], name: "index_lessonusers_on_lesson_id"
  add_index "lessonusers", ["user_id"], name: "index_lessonusers_on_user_id"

  create_table "merchants", force: :cascade do |t|
    t.string   "business_dba"
    t.integer  "mid"
    t.string   "business_type_primary"
    t.string   "business_type_secondary"
    t.integer  "sic_1"
    t.integer  "sic_2"
    t.integer  "sic_3"
    t.decimal  "interchange_percentage"
    t.decimal  "avg_ticket"
    t.decimal  "amex_percentage"
    t.decimal  "amex_per_item"
    t.decimal  "check_card_percentage"
    t.decimal  "amex_vol"
    t.decimal  "check_card_vol"
    t.decimal  "mc_vol"
    t.decimal  "vs_vol"
    t.decimal  "disc_vol"
    t.decimal  "debit_vol"
    t.integer  "total_transactions"
    t.integer  "amex_transactions"
    t.decimal  "interchange_fees"
    t.decimal  "total_fees"
    t.integer  "debit_transactions"
    t.decimal  "debit_network_fees"
    t.decimal  "ebt_vol"
    t.decimal  "ebt_fees"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "month"
    t.integer  "description_id"
    t.decimal  "standard_interchange_percent"
  end

  add_index "merchants", ["description_id"], name: "index_merchants_on_description_id"

  create_table "notes", force: :cascade do |t|
    t.integer  "prospect_id"
    t.text     "body"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "notes", ["prospect_id"], name: "index_notes_on_prospect_id"
  add_index "notes", ["user_id"], name: "index_notes_on_user_id"

  create_table "pricing_structures", force: :cascade do |t|
    t.string   "name"
    t.boolean  "interchange"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "processors", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "contact_name"
    t.string   "contact_phone"
    t.string   "contact_email"
    t.string   "website"
    t.boolean  "personal",         default: true
    t.integer  "processoruser_id"
  end

  add_index "processors", ["processoruser_id"], name: "index_processors_on_processoruser_id"

  create_table "processorusers", force: :cascade do |t|
    t.integer  "processor_id"
    t.integer  "user_id"
    t.integer  "agentnumber"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "processorusers", ["processor_id"], name: "index_processorusers_on_processor_id"
  add_index "processorusers", ["user_id"], name: "index_processorusers_on_user_id"

  create_table "programs", force: :cascade do |t|
    t.integer  "processor_id"
    t.string   "name"
    t.decimal  "min_volume"
    t.decimal  "max_volume"
    t.decimal  "up_front_bonus"
    t.decimal  "residual_split"
    t.decimal  "min_bp_mark_up"
    t.decimal  "min_per_item_fee"
    t.string   "cost_structure"
    t.string   "terminal_type"
    t.string   "terminal_ownership_type"
    t.decimal  "per_item_cost"
    t.decimal  "bin_sponsorship"
    t.decimal  "visa_access_per_item"
    t.decimal  "visa_access_percentage"
    t.decimal  "mc_access_per_item"
    t.decimal  "mc_access_percentage"
    t.decimal  "disc_access_per_item"
    t.decimal  "disc_access_percentage"
    t.decimal  "min_monthly_fees"
    t.decimal  "monthly_fee_costs"
    t.decimal  "monthly_pci_fee"
    t.decimal  "monthly_pci_cost"
    t.decimal  "annual_pci_fee"
    t.decimal  "annual_pci_cost"
    t.decimal  "min_pin_debit_per_item_fee"
    t.decimal  "pin_debit_per_item_cost"
    t.decimal  "monthly_debit_fee_cost"
    t.decimal  "min_monthly_debit_fee"
    t.decimal  "next_day_funding_monthly_cost"
    t.decimal  "next_day_funding_monthly_fee"
    t.decimal  "amex_per_item_cost"
    t.decimal  "min_amex_per_item_fee"
    t.decimal  "amex_bp_cost"
    t.decimal  "min_amex_bp_fee"
    t.decimal  "application_fee_cost"
    t.decimal  "min_application_fee"
    t.decimal  "min_per_batch_fee"
    t.decimal  "per_batch_cost"
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
    t.boolean  "personal",                          default: true
    t.integer  "system_id"
    t.decimal  "min_check_card_qual"
    t.decimal  "min_check_card_midqual"
    t.decimal  "min_check_card_nonqual"
    t.decimal  "min_credit_qual"
    t.decimal  "min_credit_midqual"
    t.decimal  "min_credit_nonqual"
    t.decimal  "swiped_flat_rate"
    t.decimal  "min_check_card_per_item_surcharge"
    t.decimal  "min_credit_per_item_surcharge"
    t.decimal  "vs_check_card_per_item"
    t.integer  "vs_check_card_access_percentage"
    t.decimal  "keyed_flat_rate"
    t.integer  "pricing_structure_id"
  end

  add_index "programs", ["pricing_structure_id"], name: "index_programs_on_pricing_structure_id"
  add_index "programs", ["processor_id"], name: "index_programs_on_processor_id"

  create_table "programusers", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "program_id"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.boolean  "edit_permission", default: false
    t.boolean  "default_program", default: false
  end

  add_index "programusers", ["program_id"], name: "index_programusers_on_program_id"
  add_index "programusers", ["user_id"], name: "index_programusers_on_user_id"

  create_table "prospects", force: :cascade do |t|
    t.string   "business_name"
    t.string   "contact_name"
    t.string   "phone"
    t.string   "email"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.integer  "user_id"
    t.integer  "description_id"
    t.string   "description_primary"
    t.string   "description_secondary"
    t.string   "amex_business_type"
    t.string   "source_type"
    t.integer  "stage_id"
  end

  add_index "prospects", ["description_id"], name: "index_prospects_on_description_id"
  add_index "prospects", ["user_id", "created_at"], name: "index_prospects_on_user_id_and_created_at"
  add_index "prospects", ["user_id"], name: "index_prospects_on_user_id"

  create_table "stages", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "statements", force: :cascade do |t|
    t.decimal  "total_fees"
    t.integer  "batches"
    t.integer  "amex_trans"
    t.decimal  "amex_vol"
    t.integer  "vmd_trans"
    t.decimal  "vmd_vol"
    t.integer  "debit_trans"
    t.decimal  "debit_vol"
    t.decimal  "interchange"
    t.string   "statement_month"
    t.decimal  "avg_ticket"
    t.decimal  "vmd_avg_ticket"
    t.decimal  "amex_avg_ticket"
    t.decimal  "debit_avg_ticket"
    t.decimal  "check_card_trans"
    t.decimal  "check_card_vol"
    t.decimal  "debit_network_fees"
    t.decimal  "amex_interchange"
    t.decimal  "vmd_interchange"
    t.decimal  "total_vol"
    t.string   "business_type"
    t.integer  "prospect_id"
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.decimal  "vs_transactions"
    t.decimal  "vs_volume"
    t.decimal  "vs_fees"
    t.decimal  "ds_transactions"
    t.decimal  "ds_volume"
    t.decimal  "ds_fees"
    t.decimal  "mc_transactions"
    t.decimal  "mc_volume"
    t.decimal  "mc_fees"
    t.decimal  "amex_per_item_cost"
    t.decimal  "amex_percentage_cost"
    t.decimal  "check_card_percentage"
    t.decimal  "unreg_debit_vol"
    t.decimal  "unreg_debit_percentage"
    t.decimal  "btob_vol"
    t.decimal  "btob_percentage"
    t.decimal  "downgrade_vol"
    t.decimal  "downgrade_percentage"
    t.decimal  "moto_vol"
    t.decimal  "moto_percentage"
    t.decimal  "ecomm_vol"
    t.decimal  "ecomm_percentage"
    t.decimal  "current_interchange"
    t.string   "form_name"
    t.decimal  "form_volume"
    t.decimal  "form_percentage"
    t.string   "presented_program"
    t.decimal  "c_vmd_bp_mark_up"
    t.decimal  "c_vmd_per_item_fee"
    t.decimal  "c_amex_per_item_fee"
    t.decimal  "c_amex_bp_mark_up"
    t.decimal  "c_debit_per_item_fee"
    t.decimal  "c_check_card_access_per_item"
    t.decimal  "c_check_card_access_percentage"
    t.decimal  "c_visa_access_per_item"
    t.decimal  "c_visa_access_percentage"
    t.decimal  "c_mc_access_per_item"
    t.decimal  "c_mc_access_percentage"
    t.decimal  "c_disc_access_per_item"
    t.decimal  "c_disc_access_percentage"
    t.decimal  "c_monthly_fees"
    t.decimal  "c_monthly_pci_fee"
    t.decimal  "c_monthly_debit_fee"
    t.decimal  "c_annual_fee"
    t.decimal  "c_monthly_next_day_funding_fee"
    t.decimal  "c_batch_fee"
    t.decimal  "c_other_fees"
    t.decimal  "swiped_percent"
    t.decimal  "vs_percent"
    t.decimal  "mc_percent"
    t.decimal  "ds_percent"
    t.decimal  "credit_percent"
    t.decimal  "rewards_percent"
    t.decimal  "basic_percent"
    t.decimal  "bp_mark_up_assumption"
    t.decimal  "credit_volume"
    t.decimal  "rewards_volume"
    t.decimal  "basic_volume"
    t.decimal  "swiped_vol"
    t.decimal  "amex_percent"
    t.decimal  "c_vmd_interchange"
    t.decimal  "form_vmd_interchange"
    t.decimal  "basic_er"
    t.decimal  "btob_er"
    t.decimal  "credit_card_er"
    t.decimal  "downgrade_er"
    t.decimal  "moto_er"
    t.decimal  "regulated_er"
    t.decimal  "rewards_er"
    t.decimal  "swiped_er"
    t.decimal  "unregulated_er"
    t.decimal  "vs_er"
    t.decimal  "mc_er"
    t.decimal  "ds_er"
    t.decimal  "vs_total_per_item_fees"
    t.decimal  "mc_total_per_item_fees"
    t.decimal  "ds_total_per_item_fees"
    t.decimal  "amex_total_per_item_fees"
    t.decimal  "debit_total_per_item_fees"
    t.decimal  "vs_total_bp_mark_up"
    t.decimal  "mc_total_bp_mark_up"
    t.decimal  "ds_total_bp_mark_up"
    t.decimal  "amex_total_bp_mark_up"
    t.decimal  "debit_total_bp_mark_up"
    t.decimal  "vs_per_item_fee"
    t.decimal  "mc_per_item_fee"
    t.decimal  "ds_per_item_fee"
    t.decimal  "vs_bp_mark_up"
    t.decimal  "mc_bp_mark_up"
    t.decimal  "ds_bp_mark_up"
    t.decimal  "c_debit_bp_mark_up"
    t.decimal  "vs_avg_ticket"
    t.decimal  "mc_avg_ticket"
    t.decimal  "ds_avg_ticket"
    t.integer  "c_number_of_batches"
    t.decimal  "c_network_access_fees"
    t.decimal  "c_opt_blue_fees"
    t.decimal  "vs_check_card_percentage"
    t.decimal  "mc_check_card_percentage"
    t.decimal  "ds_check_card_percentage"
    t.decimal  "vs_unreg_debit_percentage"
    t.decimal  "mc_unreg_debit_percentage"
    t.decimal  "ds_unreg_debit_percentage"
    t.decimal  "vs_btob_percentage"
    t.decimal  "mc_btob_percentage"
    t.decimal  "ds_btob_percentage"
    t.decimal  "vs_downgrade_percentage"
    t.decimal  "mc_downgrade_percentage"
    t.decimal  "ds_downgrade_percentage"
    t.decimal  "vs_moto_percentage"
    t.decimal  "mc_moto_percentage"
    t.decimal  "ds_moto_percentage"
    t.decimal  "vs_ecomm_percentage"
    t.decimal  "mc_ecomm_percentage"
    t.decimal  "ds_ecomm_percentage"
    t.decimal  "vs_basic_percentage"
    t.decimal  "mc_basic_percentage"
    t.decimal  "ds_basic_percentage"
    t.decimal  "vs_rewards_percentage"
    t.decimal  "mc_rewards_percentage"
    t.decimal  "ds_rewards_percentage"
    t.decimal  "vs_credit_percentage"
    t.decimal  "mc_credit_percentage"
    t.decimal  "ds_credit_percentage"
    t.decimal  "vs_swiped_percentage"
    t.decimal  "mc_swiped_percentage"
    t.decimal  "ds_swiped_percentage"
    t.decimal  "vs_check_card_volume"
    t.decimal  "mc_check_card_volume"
    t.decimal  "ds_check_card_volume"
    t.decimal  "vs_unreg_debit_volume"
    t.decimal  "mc_unreg_debit_volume"
    t.decimal  "ds_unreg_debit_volume"
    t.decimal  "vs_btob_volume"
    t.decimal  "mc_btob_volume"
    t.decimal  "ds_btob_volume"
    t.decimal  "vs_downgrade_volume"
    t.decimal  "mc_downgrade_volume"
    t.decimal  "ds_downgrade_volume"
    t.decimal  "vs_moto_volume"
    t.decimal  "mc_moto_volume"
    t.decimal  "ds_moto_volume"
    t.decimal  "vs_ecomm_volume"
    t.decimal  "mc_ecomm_volume"
    t.decimal  "ds_ecomm_volume"
    t.decimal  "vs_credit_volume"
    t.decimal  "mc_credit_volume"
    t.decimal  "ds_credit_volume"
    t.decimal  "vs_rewards_volume"
    t.decimal  "mc_rewards_volume"
    t.decimal  "ds_rewards_volume"
    t.decimal  "vs_basic_volume"
    t.decimal  "mc_basic_volume"
    t.decimal  "ds_basic_volume"
    t.decimal  "vs_swiped_volume"
    t.decimal  "mc_swiped_volume"
    t.decimal  "ds_swiped_volume"
    t.decimal  "default_basis_points"
    t.decimal  "default_per_item_fee"
    t.decimal  "total_passthrough"
    t.boolean  "initial_edit_complete",          default: false
  end

  add_index "statements", ["prospect_id", "created_at"], name: "index_statements_on_prospect_id_and_created_at"

  create_table "systems", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tasks", force: :cascade do |t|
    t.integer  "prospect_id"
    t.text     "body"
    t.integer  "user_id"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.date     "finish_date"
    t.datetime "completed_at"
    t.boolean  "completed",    default: false
  end

  add_index "tasks", ["prospect_id"], name: "index_tasks_on_prospect_id"
  add_index "tasks", ["user_id"], name: "index_tasks_on_user_id"

  create_table "team_types", force: :cascade do |t|
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "team_user_roles", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.boolean  "bill_to"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "team_users", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "team_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "team_user_role_id"
    t.string   "email"
  end

  add_index "team_users", ["team_id"], name: "index_team_users_on_team_id"
  add_index "team_users", ["team_user_role_id"], name: "index_team_users_on_team_user_role_id"
  add_index "team_users", ["user_id"], name: "index_team_users_on_user_id"

  create_table "teams", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "team_type_id"
    t.integer  "chat_id"
  end

  add_index "teams", ["team_type_id"], name: "index_teams_on_team_type_id"

  create_table "tickets", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "admin_user_id"
    t.text     "body"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.boolean  "important",     default: false
  end

  add_index "tickets", ["user_id"], name: "index_tickets_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.boolean  "admin",                  default: false
    t.boolean  "training_subscribed",    default: false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "phone_number"
    t.boolean  "paid",                   default: false
    t.string   "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type"
    t.integer  "invitations_count",      default: 0
    t.string   "avatar"
    t.boolean  "processor_employee"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["invitation_token"], name: "index_users_on_invitation_token", unique: true
  add_index "users", ["invitations_count"], name: "index_users_on_invitations_count"
  add_index "users", ["invited_by_id"], name: "index_users_on_invited_by_id"
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
