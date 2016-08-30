class AddFormFieldToStatements < ActiveRecord::Migration
  def change
    add_column :statements, :form_name, :string
  end
end
