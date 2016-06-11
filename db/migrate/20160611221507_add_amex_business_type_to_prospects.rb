class AddAmexBusinessTypeToProspects < ActiveRecord::Migration
  def change
    add_column :prospects, :amex_business_type, :string
  end
end
