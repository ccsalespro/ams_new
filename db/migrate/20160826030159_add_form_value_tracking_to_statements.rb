class AddFormValueTrackingToStatements < ActiveRecord::Migration
  def change
    add_column :statements, :form_volume, :decimal
    add_column :statements, :form_percentage, :decimal
  end
end
