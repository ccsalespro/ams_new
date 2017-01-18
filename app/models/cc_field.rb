class CcField < ActiveRecord::Base
  belongs_to :comparison
  belongs_to :custom_field_type
end
