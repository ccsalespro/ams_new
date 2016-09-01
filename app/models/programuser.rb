class Programuser < ActiveRecord::Base
  belongs_to :user
  belongs_to :program

  after_create :create_notification

  def create_notification
    user = User.find_by_id(self.user_id)
    program = Program.find_by_id(self.program_id)
    AdminMailer.new_program(program, user).deliver
  end
end
