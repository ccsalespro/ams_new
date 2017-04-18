class AddCardTypeToInttableitems < ActiveRecord::Migration
  def change
    add_column :inttableitems, :card_type, :string
  end
end
