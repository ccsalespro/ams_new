class AddStatementIdToIntcalcitems < ActiveRecord::Migration
  def change
    add_reference :intcalcitems, :statement, index: true, foreign_key: true
    add_reference :intcalcitems, :prospect, index: true, foreign_key: true
    add_column :intcalcitems, :inttype_percent, :decimal
    add_column :intcalcitems, :description_id, :integer
  end
end
