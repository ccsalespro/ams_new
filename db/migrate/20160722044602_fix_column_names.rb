class FixColumnNames < ActiveRecord::Migration
  def change
  	rename_column :processors, :private, :personal
  	rename_column :programs, :private, :personal
  end
end
