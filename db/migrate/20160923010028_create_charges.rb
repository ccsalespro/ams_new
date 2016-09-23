class CreateCharges < ActiveRecord::Migration
  def change
    create_table :charges do |t|
      t.integer :user_id
      t.string :stripeid
      t.integer :amount
      t.string :card_last4
      t.string :card_exp_month
      t.string :card_exp_year
      t.string :card_type

      t.timestamps null: false
    end

    add_index :charges, :stripeid, unique: true
  end
end
