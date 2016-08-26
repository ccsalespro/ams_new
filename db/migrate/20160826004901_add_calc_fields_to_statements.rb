class AddCalcFieldsToStatements < ActiveRecord::Migration
  def change
    add_column :statements, :check_card_percentage, :decimal
    add_column :statements, :unreg_debit_vol, :decimal
    add_column :statements, :unreg_debit_percentage, :decimal
    add_column :statements, :btob_vol, :decimal
    add_column :statements, :btob_percentage, :decimal
    add_column :statements, :downgrade_vol, :decimal
    add_column :statements, :downgrade_percentage, :decimal
    add_column :statements, :moto_vol, :decimal
    add_column :statements, :moto_percentage, :decimal
    add_column :statements, :ecomm_vol, :decimal
    add_column :statements, :ecomm_percentage, :decimal
    add_column :statements, :current_interchange, :decimal
  end
end
