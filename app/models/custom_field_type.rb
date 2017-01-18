class CustomFieldType < ActiveRecord::Base
  has_many :custom_fields
  has_many :cc_fields
end
