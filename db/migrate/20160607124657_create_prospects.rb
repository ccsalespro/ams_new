class CreateProspects < ActiveRecord::Migration
  def change
    create_table :prospects do |t|
      t.string :business_name
      t.string :contact_name
      t.string :phone
      t.string :email

      t.timestamps null: false
    end
  end
end
