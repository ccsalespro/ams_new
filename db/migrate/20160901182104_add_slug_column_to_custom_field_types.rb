class AddSlugColumnToCustomFieldTypes < ActiveRecord::Migration
  def change
    add_column :custom_field_types, :slug_string, :string
  end
end
