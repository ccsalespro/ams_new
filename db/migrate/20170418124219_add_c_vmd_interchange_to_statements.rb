class AddCVmdInterchangeToStatements < ActiveRecord::Migration
  def change
    add_column :statements, :c_vmd_interchange, :decimal
    add_column :statements, :form_vmd_interchange, :decimal
  end
end
