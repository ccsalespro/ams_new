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

ActiveRecord::Schema.define(version: 20160802160743) do

  create_table "actions", force: :cascade do |t|
    t.string   "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "blogs", force: :cascade do |t|
    t.string   "title"
    t.string   "body"
    t.string   "author"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "chapters", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "course_id"
  end

  add_index "chapters", ["course_id"], name: "index_chapters_on_course_id"

  create_table "comments", force: :cascade do |t|
    t.integer  "blog_id"
    t.text     "body"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "comments", ["blog_id"], name: "index_comments_on_blog_id"
  add_index "comments", ["user_id"], name: "index_comments_on_user_id"

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
    t.integer  "bp_mark_up"
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

  create_table "descriptions", force: :cascade do |t|
    t.string   "business_type_primary"
    t.string   "business_type_secondary"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "amex_business_type"
  end

  create_table "images", force: :cascade do |t|
    t.string   "filename"
    t.string   "content_type"
    t.binary   "file_contents"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "intcalcitems", force: :cascade do |t|
    t.integer  "inttype_id"
    t.integer  "transactions"
    t.decimal  "volume"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "statement_id"
    t.integer  "prospect_id"
    t.decimal  "inttype_percent"
    t.integer  "description_id"
  end

  add_index "intcalcitems", ["inttype_id"], name: "index_intcalcitems_on_inttype_id"
  add_index "intcalcitems", ["prospect_id"], name: "index_intcalcitems_on_prospect_id"
  add_index "intcalcitems", ["statement_id"], name: "index_intcalcitems_on_statement_id"

  create_table "internal_contacts", force: :cascade do |t|
    t.string   "full_name"
    t.string   "phone_number"
    t.string   "email_address"
    t.text     "message"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
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
    t.integer  "transactions"
    t.decimal  "volume"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.decimal  "costs"
  end

  add_index "inttableitems", ["inttype_id"], name: "index_inttableitems_on_inttype_id"
  add_index "inttableitems", ["statement_id"], name: "index_inttableitems_on_statement_id"

  create_table "inttypes", force: :cascade do |t|
    t.string   "card_type"
    t.string   "description"
    t.decimal  "percent"
    t.decimal  "per_item"
    t.decimal  "max"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "lessons", force: :cascade do |t|
    t.string   "title"
    t.string   "video"
    t.integer  "minutes"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "chapter_id"
    t.datetime "completed_at"
    t.text     "description"
  end

  add_index "lessons", ["chapter_id"], name: "index_lessons_on_chapter_id"

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
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "month"
    t.integer  "description_id"
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

  create_table "plans", force: :cascade do |t|
    t.string   "name"
    t.integer  "stripe_plan_id"
    t.decimal  "price"
    t.integer  "trial_days"
    t.text     "description"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
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
    t.string   "keyed_flat_rate_decimal"
    t.decimal  "min_check_card_per_item_surcharge"
    t.decimal  "min_credit_per_item_surcharge"
  end

  add_index "programs", ["processor_id"], name: "index_programs_on_processor_id"

  create_table "programusers", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "program_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.decimal  "vs_transactions"
    t.decimal  "vs_volume"
    t.decimal  "vs_fees"
    t.decimal  "ds_transactions"
    t.decimal  "ds_volume"
    t.decimal  "ds_fees"
    t.decimal  "mc_transactions"
    t.decimal  "mc_volume"
    t.decimal  "mc_fees"
  end

  create_table "structures", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "subscriptions", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "plan_id"
    t.boolean  "active"
    t.string   "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "subscriptions", ["plan_id"], name: "index_subscriptions_on_plan_id"
  add_index "subscriptions", ["user_id"], name: "index_subscriptions_on_user_id"

  create_table "systems", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tasks", force: :cascade do |t|
    t.integer  "prospect_id"
    t.text     "body"
    t.integer  "user_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.date     "finish_date"
    t.datetime "completed_at"
  end

  add_index "tasks", ["prospect_id"], name: "index_tasks_on_prospect_id"
  add_index "tasks", ["user_id"], name: "index_tasks_on_user_id"

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
    t.boolean  "subscribed",             default: false
    t.string   "stripeid"
    t.boolean  "admin",                  default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
