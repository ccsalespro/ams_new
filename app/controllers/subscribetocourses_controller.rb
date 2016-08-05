class SubscribetocoursesController < ApplicationController
  before_action :set_subscribetocourse, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def new
  end

  def create
    if current_user.admin == false
      token = params[:stripeToken]
        Stripe.api_key = "sk_test_ZnRymlshHgxHQZch8e8tW2KC"
        customer = Stripe::Customer.create(
          card: token,
          plan: 22,
          email: current_user.email
          )
        current_user.training_subscribed = true
        current_user.stripeid = customer.id
        current_user.save

        redirect_to courses_path, notice: 'Successfully Subscribed'
    end

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
    if current_user.admin?
        current_user.training_subscribed = true
        current_user.save
      redirect_to courses_path, notice: 'Successfully Subscribed'
    end
  end
end
