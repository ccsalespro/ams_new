class AddServiceFeeToComparisons < ActiveRecord::Migration
  def change
    add_column :comparisons, :service_fee, :decimal
    add_column :comparisons, :service_fees, :decimal
  end
end
