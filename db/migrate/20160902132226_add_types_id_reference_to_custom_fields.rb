class AddTypesIdReferenceToCustomFields < ActiveRecord::Migration
  def change
    add_reference :custom_fields, :custom_field_type, index: true, foreign_key: true
  end
end
