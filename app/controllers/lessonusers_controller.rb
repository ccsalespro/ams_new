 class LessonusersController < ApplicationController
  
  def complete
  	@lesson = Lesson.find(params[:id])
  	@lessonusers = Lessonuser.where(user_id: current_user.id)
  	@lessonusers.each do |lessonuser|
  		if lessonuser.lesson_id == @lesson.id
		  	lessonuser.update_attribute(:completed_at, Time.now)
		    redirect_to course_chapter_lesson_path(lessonuser.course_id, lessonuser.chapter_id, lessonuser.lesson_id)
		  end
  	end
  end


 end