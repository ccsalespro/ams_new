class AddBpAssumptionsToStatements < ActiveRecord::Migration
  def change
    add_column :statements, :bp_mark_up_assumption, :decimal
  end
end
