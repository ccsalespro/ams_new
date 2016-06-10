class CreateDescriptions < ActiveRecord::Migration
  def change
    create_table :descriptions do |t|
      t.string :business_type_primary
      t.string :business_type_secondary

      t.timestamps null: false
    end
  end
end
