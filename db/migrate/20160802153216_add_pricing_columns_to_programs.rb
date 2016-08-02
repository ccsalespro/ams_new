class AddPricingColumnsToPrograms < ActiveRecord::Migration
  def change
    add_column :programs, :min_check_card_qual, :decimal
    add_column :programs, :min_check_card_midqual, :decimal
    add_column :programs, :min_check_card_nonqual, :decimal
    add_column :programs, :min_credit_qual, :decimal
    add_column :programs, :min_credit_midqual, :decimal
    add_column :programs, :min_credit_nonqual, :decimal
    add_column :programs, :swiped_flat_rate, :decimal
    add_column :programs, :keyed_flat_rate_decimal, :string
    add_column :programs, :min_check_card_per_item_surcharge, :decimal
    add_column :programs, :min_credit_per_item_surcharge, :decimal
  end
end
