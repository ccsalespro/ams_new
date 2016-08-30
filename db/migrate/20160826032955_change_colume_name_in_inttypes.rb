class ChangeColumeNameInInttypes < ActiveRecord::Migration
  def change
  	rename_column :inttypes, :Downgrade, :downgrade
  	rename_column :inttypes, :B2B, :btob
  	rename_column :inttypes, :B2C, :btoc
  	rename_column :inttypes, :Keyed, :keyed
  	rename_column :inttypes, :CVV, :cvv
  	rename_column :inttypes, :Swiped, :swiped
  	rename_column :inttypes, :Zip, :zip
  	rename_column :inttypes, :Address, :address
  	rename_column :inttypes, :Name, :name
  	rename_column :inttypes, :TE, :te
  end
end
