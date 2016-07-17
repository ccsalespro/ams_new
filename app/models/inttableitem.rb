class Inttableitem < ActiveRecord::Base
  belongs_to :inttype
  belongs_to :statement
end
