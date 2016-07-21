class AddDefaultValueToSubscribed < ActiveRecord::Migration
  def up
  	change_column :users, :subscribed, :boolean, :default => false
  end
  def down
  	change_column :users, :subscribed, :boolean, :default => nil
  end
end
