class Intcalcitem < ActiveRecord::Base
  belongs_to :inttype
  belongs_to :statement
  belongs_to :prospect
  
  def self.to_csv
		CSV.generate do |csv|
			csv << column_names
			all.each do |intcalcitem|
				csv << intcalcitem.attributes.values_at(*column_names)
			end	
		end
	end

  default_scope -> { order(transactions: :desc) }
end
