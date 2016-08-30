class AddAvgTicketToInttableitems < ActiveRecord::Migration
  def change
    add_column :inttableitems, :avg_ticket, :decimal
    add_column :intcalcitems, :avg_ticket_variance, :decimal
    add_column :descriptions, :avg_ticket, :decimal
  end
end
