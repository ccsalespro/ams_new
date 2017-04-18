class AddAssumptionVolumeByBrandToStatements < ActiveRecord::Migration
  def change
    add_column :statements, :vs_check_card_volume, :decimal
    add_column :statements, :mc_check_card_volume, :decimal
    add_column :statements, :ds_check_card_volume, :decimal
    add_column :statements, :vs_unreg_debit_volume, :decimal
    add_column :statements, :mc_unreg_debit_volume, :decimal
    add_column :statements, :ds_unreg_debit_volume, :decimal
    add_column :statements, :vs_btob_volume, :decimal
    add_column :statements, :mc_btob_volume, :decimal
    add_column :statements, :ds_btob_volume, :decimal
    add_column :statements, :vs_downgrade_volume, :decimal
    add_column :statements, :mc_downgrade_volume, :decimal
    add_column :statements, :ds_downgrade_volume, :decimal
    add_column :statements, :vs_moto_volume, :decimal
    add_column :statements, :mc_moto_volume, :decimal
    add_column :statements, :ds_moto_volume, :decimal
    add_column :statements, :vs_ecomm_volume, :decimal
    add_column :statements, :mc_ecomm_volume, :decimal
    add_column :statements, :ds_ecomm_volume, :decimal
    add_column :statements, :vs_credit_volume, :decimal
    add_column :statements, :mc_credit_volume, :decimal
    add_column :statements, :ds_credit_volume, :decimal
    add_column :statements, :vs_rewards_volume, :decimal
    add_column :statements, :mc_rewards_volume, :decimal
    add_column :statements, :ds_rewards_volume, :decimal
    add_column :statements, :vs_basic_volume, :decimal
    add_column :statements, :mc_basic_volume, :decimal
    add_column :statements, :ds_basic_volume, :decimal
    add_column :statements, :vs_swiped_volume, :decimal
    add_column :statements, :mc_swiped_volume, :decimal
    add_column :statements, :ds_swiped_volume, :decimal
  end
end
