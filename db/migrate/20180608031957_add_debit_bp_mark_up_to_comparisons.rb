class AddDebitBpMarkUpToComparisons < ActiveRecord::Migration
  def change
    add_column :comparisons, :debit_bp_mark_up, :decimal
  end
end
