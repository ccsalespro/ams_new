class AddAssumptionPercentByBrandToStatements < ActiveRecord::Migration
  def change
    add_column :statements, :vs_check_card_percentage, :decimal
    add_column :statements, :mc_check_card_percentage, :decimal
    add_column :statements, :ds_check_card_percentage, :decimal
    add_column :statements, :vs_unreg_debit_percentage, :decimal
    add_column :statements, :mc_unreg_debit_percentage, :decimal
    add_column :statements, :ds_unreg_debit_percentage, :decimal
    add_column :statements, :vs_btob_percentage, :decimal
    add_column :statements, :mc_btob_percentage, :decimal
    add_column :statements, :ds_btob_percentage, :decimal
    add_column :statements, :vs_downgrade_percentage, :decimal
    add_column :statements, :mc_downgrade_percentage, :decimal
    add_column :statements, :ds_downgrade_percentage, :decimal
    add_column :statements, :vs_moto_percentage, :decimal
    add_column :statements, :mc_moto_percentage, :decimal
    add_column :statements, :ds_moto_percentage, :decimal
    add_column :statements, :vs_ecomm_percentage, :decimal
    add_column :statements, :mc_ecomm_percentage, :decimal
    add_column :statements, :ds_ecomm_percentage, :decimal
    add_column :statements, :vs_basic_percentage, :decimal
    add_column :statements, :mc_basic_percentage, :decimal
    add_column :statements, :ds_basic_percentage, :decimal
    add_column :statements, :vs_rewards_percentage, :decimal
    add_column :statements, :mc_rewards_percentage, :decimal
    add_column :statements, :ds_rewards_percentage, :decimal
    add_column :statements, :vs_credit_percentage, :decimal
    add_column :statements, :mc_credit_percentage, :decimal
    add_column :statements, :ds_credit_percentage, :decimal
    add_column :statements, :vs_swiped_percentage, :decimal
    add_column :statements, :mc_swiped_percentage, :decimal
    add_column :statements, :ds_swiped_percentage, :decimal
  end
end
