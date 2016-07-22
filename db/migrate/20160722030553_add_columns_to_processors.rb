class AddColumnsToProcessors < ActiveRecord::Migration
  def change
    add_column :processors, :contact_name, :string
    add_column :processors, :contact_phone, :string
    add_column :processors, :contact_email, :string
    add_column :processors, :website, :string
    add_column :processors, :private, :boolean
    add_reference :processors, :processoruser, index: true, foreign_key: true
  end
end
