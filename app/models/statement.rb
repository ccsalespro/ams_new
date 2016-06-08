class Statement < ActiveRecord::Base
  belongs_to :prospect
  has_and_belongs_to_many :costs
end
