class AddB2BToInttypes < ActiveRecord::Migration
  def change
    add_column :inttypes, :B2B, :boolean, :default => false
    add_column :inttypes, :B2C, :boolean, :default => false
    add_column :inttypes, :Keyed, :boolean, :default => false
    add_column :inttypes, :Swiped, :boolean, :default => false
    add_column :inttypes, :ecomm, :boolean, :default => false
    add_column :inttypes, :CVV, :boolean, :default => false
    add_column :inttypes, :Zip, :boolean, :default => false
    add_column :inttypes, :Address, :boolean, :default => false
    add_column :inttypes, :Name, :boolean, :default => false
    add_column :inttypes, :Downgrade, :boolean, :default => false
    add_column :inttypes, :biz_type, :string
    add_column :inttypes, :max_ticket, :decimal

  end
end
