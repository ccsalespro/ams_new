class AddBusinessDbaToMerchants < ActiveRecord::Migration
  def change
    add_column :merchants, :business_dba, :string
  end
end
