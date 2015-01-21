module CoursesHelper

  def render_course_semester course
    semester = Semester.find(course.semester_id).name
    case semester
      when "上學期"
        "上"
      when "下學期"
        "下"
      else
        "暑"  
    end
  end

  def render_course_owner course
    User.find(course.user_id).name
  end

  def render_course_download course
    link_to simple_name(course.data), :controller => :courses, :action => 'download_file', :id => course.id
  end

  def render_course_note course
    simple_format(course.note)
  end

  def render_course_year course
    course.created_at.to_date
  end

  def render_course_update course
    if current_user && course.editable_by?(current_user)
      link_to '更新', edit_course_path(course), class: "btn btn-default btn-xs"
    end
  end

  def render_course_destroy course
    if current_user && course.editable_by?(current_user)
      link_to '刪除', course, method: :delete, data: { confirm: 'Are you sure?' }, class: "btn btn-default btn-xs"
    end
  end
end
