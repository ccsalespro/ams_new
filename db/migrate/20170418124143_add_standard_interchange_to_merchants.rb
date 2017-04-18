class AddStandardInterchangeToMerchants < ActiveRecord::Migration
  def change
    add_column :merchants, :standard_interchange_percent, :decimal
  end
end
