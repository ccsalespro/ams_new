class CustomField < ActiveRecord::Base
	belongs_to :program
	belongs_to :custom_field_type
end
