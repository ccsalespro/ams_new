class CreateCustomFieldTypes < ActiveRecord::Migration
  def change
    create_table :custom_field_types do |t|
      t.string :name
      t.string :description
      

      t.timestamps null: false
    end
  end
end
