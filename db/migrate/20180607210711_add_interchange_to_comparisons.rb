class AddInterchangeToComparisons < ActiveRecord::Migration
  def change
    add_column :comparisons, :interchange, :decimal
    add_column :comparisons, :debit_network_fees, :decimal
    add_column :comparisons, :amex_interchange, :decimal
  end
end
