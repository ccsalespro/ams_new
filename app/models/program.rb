class Program < ActiveRecord::Base
  belongs_to :Processor
  def self.import(file)
		CSV.foreach(file.path, headers: true, :encoding => 'windows-1251:utf-8') do |row|
			Program.create! row.to_hash
		end	
	end
end
