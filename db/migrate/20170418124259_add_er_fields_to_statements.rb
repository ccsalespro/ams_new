class AddErFieldsToStatements < ActiveRecord::Migration
  def change
    add_column :statements, :basic_er, :decimal
    add_column :statements, :btob_er, :decimal
    add_column :statements, :credit_card_er, :decimal
    add_column :statements, :downgrade_er, :decimal
    add_column :statements, :moto_er, :decimal
    add_column :statements, :regulated_er, :decimal
    add_column :statements, :rewards_er, :decimal
    add_column :statements, :swiped_er, :decimal
    add_column :statements, :unregulated_er, :decimal
    add_column :statements, :vs_er, :decimal
    add_column :statements, :mc_er, :decimal
    add_column :statements, :ds_er, :decimal
  end
end
