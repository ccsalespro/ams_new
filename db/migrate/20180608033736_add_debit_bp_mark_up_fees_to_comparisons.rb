class AddDebitBpMarkUpFeesToComparisons < ActiveRecord::Migration
  def change
    add_column :comparisons, :debit_bp_mark_up_fees, :decimal
  end
end
