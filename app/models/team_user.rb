class TeamUser < ActiveRecord::Base
	
	belongs_to :user
	belongs_to :team
	belongs_to :team_user_role
	validates :user_id, :presence => true, :uniqueness => {:scope => :team_id}
	before_validation :set_user_id
	after_create :set_team_user_role

	def set_user_id
		@email = self.email
		if @email != nil
			existing_user = User.find_by(email: @email)
			self.user = if existing_user.present?
			            existing_user
			          else
			            User.invite!(:email => @email)
			          end
		end
	end

	def set_team_user_role
		if self.team_user_role_id == nil
			case self.team.team_type.description
				when "Processor"
					self.team_user_role_id = 10
				when "ISO"
					self.team_user_role_id = 6
				when "Affiliate"
					self.team_user_role_id = 5
				when "Recruiter"
					self.team_user_role_id = 5
				when "Admin"
					self.team_user_role_id = 10
			end 
		  self.save
		end
	end

end
