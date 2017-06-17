class AddDefaultFieldToPrograms < ActiveRecord::Migration
  def change
    add_column :programusers, :default_program, :boolean, default: false
  end
end
