class AddEditPermissionToProgramusers < ActiveRecord::Migration
  def change
    add_column :programusers, :edit_permission, :boolean, default: false
  end
end
