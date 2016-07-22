class SubscribersController < ApplicationController

	before_filter :authenticate_user!
	
	def new
	end

	def update
		token = params[:stripeToken]
		customer = Stripe::Customer.create(
			card: token,
			plan: 1002,
			email: current_user.email
			)
		current_user.subscribed = true
		current_user.stripeid = customer.id
		current_user.save

		@programs = Program.all.where(personal: false)
		@programs.each do |program|
			@programuser = Programuser.new
			@programuser.user_id = current_user.id
			@programuser.program_id = program.id
			@programuser.save!
		end

		@processors = Processor.all.where(personal: false)
		@processors.each do |processor|
			@processoruser = Processoruser.new
			@processoruser.user_id = current_user.id
			@processoruser.processor_id = processor.id
			@processoruser.save!
		end

		redirect_to prospects_path
	end
end
