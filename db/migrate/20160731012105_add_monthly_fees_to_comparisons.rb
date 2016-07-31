class AddMonthlyFeesToComparisons < ActiveRecord::Migration
  def change
    add_column :comparisons, :monthly_fees, :decimal
    add_column :comparisons, :monthly_pci_fees, :decimal
    add_column :comparisons, :annual_fee, :decimal
    add_column :comparisons, :annual_pci_fees, :decimal
  end
end
