class AddNewPercentFieldsToStatements < ActiveRecord::Migration
  def change
    add_column :statements, :swiped_percent, :decimal
    add_column :statements, :vs_percent, :decimal
    add_column :statements, :mc_percent, :decimal
    add_column :statements, :ds_percent, :decimal
    add_column :statements, :credit_percent, :decimal
    add_column :statements, :rewards_percent, :decimal
    add_column :statements, :basic_percent, :decimal
  end
end
