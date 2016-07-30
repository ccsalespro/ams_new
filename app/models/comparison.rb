class Comparison < ActiveRecord::Base
  belongs_to :statement
  belongs_to :program
end
