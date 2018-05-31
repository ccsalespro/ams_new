class AddPricingStructureReferenceToPrograms < ActiveRecord::Migration
  def change
    add_reference :programs, :pricing_structure, index: true, foreign_key: true
  end
end
