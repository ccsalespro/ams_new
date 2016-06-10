class CreateProspects < ActiveRecord::Migration
  def change
    create_table :prospects do |t|
      t.string :business_name
      t.string :contact_name
      t.string :phone
      t.string :email
      t.references :description, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
