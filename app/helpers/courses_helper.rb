module CoursesHelper
  def course_owner course
    User.find(course.user_id).name
  end
end
