class AddAssumptionsVolumeFieldsToStatements < ActiveRecord::Migration
  def change
    add_column :statements, :credit_volume, :decimal
    add_column :statements, :rewards_volume, :decimal
    add_column :statements, :basic_volume, :decimal
  end
end
