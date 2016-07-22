class CreateInternalContacts < ActiveRecord::Migration
  def change
    create_table :internal_contacts do |t|
      t.string :full_name
      t.string :phone_number
      t.string :email_address
      t.text :message

      t.timestamps null: false
    end
  end
end
