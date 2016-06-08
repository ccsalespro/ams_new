class CreateCosts < ActiveRecord::Migration
  def change
    create_table :costs do |t|
      t.string :business_type
      t.string :payment_type
      t.decimal :low_ticket
      t.decimal :high_ticket
      t.decimal :per_item_value
      t.decimal :percentage_value

      t.timestamps null: false
    end
  end
end
