class AddReadToInternalContacts < ActiveRecord::Migration
  def change
    add_column :internal_contacts, :read, :boolean, default: false
  end
end
