class AddAvgTicketBrandsToStatements < ActiveRecord::Migration
  def change
  	add_column :statements, :vs_total_per_item_fees, :decimal
  	add_column :statements, :mc_total_per_item_fees, :decimal
  	add_column :statements, :ds_total_per_item_fees, :decimal
    add_column :statements, :amex_total_per_item_fees, :decimal
    add_column :statements, :debit_total_per_item_fees, :decimal
  	add_column :statements, :vs_total_bp_mark_up, :decimal
  	add_column :statements, :mc_total_bp_mark_up, :decimal
  	add_column :statements, :ds_total_bp_mark_up, :decimal
    add_column :statements, :amex_total_bp_mark_up, :decimal
    add_column :statements, :debit_total_bp_mark_up, :decimal
  	add_column :statements, :vs_per_item_fee, :decimal
  	add_column :statements, :mc_per_item_fee, :decimal
  	add_column :statements, :ds_per_item_fee, :decimal
  	add_column :statements, :vs_bp_mark_up, :decimal
  	add_column :statements, :mc_bp_mark_up, :decimal
  	add_column :statements, :ds_bp_mark_up, :decimal
    add_column :statements, :c_debit_bp_mark_up, :decimal
    add_column :statements, :vs_avg_ticket, :decimal
    add_column :statements, :mc_avg_ticket, :decimal
    add_column :statements, :ds_avg_ticket, :decimal
  end
end
