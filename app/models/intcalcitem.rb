class Intcalcitem < ActiveRecord::Base
  belongs_to :inttype
  belongs_to :statement
  belongs_to :prospect
end
