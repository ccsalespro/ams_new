class AddAmexBusinessTypeToDescriptions < ActiveRecord::Migration
  def change
    add_column :descriptions, :amex_business_type, :string
  end
end
