class CreatePricingStructures < ActiveRecord::Migration
  def change
    create_table :pricing_structures do |t|
      t.string :name
      t.boolean :interchange

      t.timestamps null: false
    end
  end
end
