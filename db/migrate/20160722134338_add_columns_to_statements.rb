class AddColumnsToStatements < ActiveRecord::Migration
  def change
    add_column :statements, :vs_transactions, :decimal
    add_column :statements, :vs_volume, :decimal
    add_column :statements, :vs_fees, :decimal
    add_column :statements, :ds_transactions, :decimal
    add_column :statements, :ds_volume, :decimal
    add_column :statements, :ds_fees, :decimal
    add_column :statements, :mc_transactions, :decimal
    add_column :statements, :mc_volume, :decimal
    add_column :statements, :mc_fees, :decimal
  end
end
