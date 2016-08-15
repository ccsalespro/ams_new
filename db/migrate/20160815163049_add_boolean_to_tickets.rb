class AddBooleanToTickets < ActiveRecord::Migration
  def change
    add_column :tickets, :important, :boolean, default: false
  end
end
