class Statement < ActiveRecord::Base
  belongs_to :prospect
  has_and_belongs_to_many :costs
  has_many :inttableitems
  has_many :inttypes, through: :inttableitems
  has_many :intcalcitems
  validates_presence_of :total_vol
end
