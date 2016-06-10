class AddDataNumberToMerchants < ActiveRecord::Migration
  def change
    add_column :merchants, :data_number, :integer
  end
end
