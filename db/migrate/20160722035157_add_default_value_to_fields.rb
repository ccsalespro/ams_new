class AddDefaultValueToFields < ActiveRecord::Migration
  def up
  	change_column :programs, :private, :boolean, :default => true
  	change_column :processors, :private, :boolean, :default => true
  end
  def down
  	change_column :programs, :private, :boolean, :default => nil
  	change_column :processors, :private, :boolean, :default => nil
  end
end
