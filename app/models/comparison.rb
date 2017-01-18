class Comparison < ActiveRecord::Base
  belongs_to :statement
  belongs_to :program
  has_many :cc_fields
  accepts_nested_attributes_for :cc_fields 
end
