class Stage < ActiveRecord::Base
	has_many :prospects

  def self.import(file)
    CSV.foreach(file.path, headers: true, :encoding => 'windows-1251:utf-8') do |row|
      Stage.create! row.to_hash
    end
  end
end
