class Prospect < ActiveRecord::Base
	has_many :statements
	belongs_to :user
	belongs_to :description

	searchable do
		text :business_name, :boost => 3
		text :contact_name
	end
end