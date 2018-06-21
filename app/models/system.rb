class System < ActiveRecord::Base
	has_many :programs

  def self.import(file)
    CSV.foreach(file.path, headers: true, :encoding => 'windows-1251:utf-8') do |row|
      System.create! row.to_hash
    end
  end
end
