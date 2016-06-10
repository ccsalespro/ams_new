class Merchant < ActiveRecord::Base
	def self.import(file)
		CSV.foreach(file.path, headers: true, :encoding => 'windows-1251:utf-8') do |row|
			Merchant.create! row.to_hash
		end	
	end
end
