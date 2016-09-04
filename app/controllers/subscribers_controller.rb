class SubscribersController < ApplicationController

	before_filter :authenticate_user!
	
	def new
		if current_user.subscribed == true
			redirect_to prospects_path
		end
	end

	def update
		token = params[:stripeToken]
		customer = Stripe::Customer.create(
			card: token,
			plan: 1030,
			email: current_user.email
			)
		current_user.subscribed = true
		current_user.training_subscribed = true
		current_user.paid = true
		current_user.stripeid = customer.id
		current_user.save

		@courses = Course.all
    @courses.each do |course|
      @courseuser = Courseuser.new
      @courseuser.user_id = current_user.id
      @courseuser.course_id = course.id
      @courseuser.save

      course.chapters.each do |chapter|
       @chapteruser = Chapteruser.new
       @chapteruser.user_id = current_user.id
       @chapteruser.course_id = course.id
       @chapteruser.chapter_id = chapter.id
       @chapteruser.save

       chapter.lessons.each do |lesson|
        @lessonuser = Lessonuser.new
        @lessonuser.user_id = current_user.id
        @lessonuser.course_id = course.id
        @lessonuser.chapter_id = chapter.id
        @lessonuser.lesson_id = lesson.id
        @lessonuser.save
       end
      end
    end

		redirect_to prospects_path
	end
end
