class AddPresentedProgramToStatements < ActiveRecord::Migration
  def change
    add_column :statements, :presented_program, :string
  end
end
