class Processor < ActiveRecord::Base
	has_many :programs, dependent: :destroy
	has_many :processorusers, dependent: :destroy
	has_many :users, through: :processorusers
end
