module CoursesHelper

  def render_course_semester course
    semester = Semester.find(course.semester_id).name
    case semester
      when "上學期"
        "上"
      when "下學期"
        "下"
      when "暑期"
        "暑期"
      else
        "其他"
    end
  end

  def render_course_owner course
    course.owner.name
  end

  def render_course_download course
    link_to "下載", :controller => :courses, :action => 'download_file', :id => course.id, :class => "btn btn-info btn-xs"
  end

  def render_course_note course
    simple_format(course.note)
  end

  def render_course_year course
    course.created_at.to_date
  end

  def render_course_update course
    if current_user && course.editable_by?(current_user)
      link_to '更新', edit_course_path(course), class: "btn btn-info btn-xs"
    end
  end

  def render_course_destroy course
    if current_user && course.editable_by?(current_user)
      link_to '刪除', course, method: :delete, data: { confirm: '確定要刪除嗎?' }, class: "btn btn-danger btn-xs"
    end
  end

  def render_course_fresh_state(course)
    if course.created_at >= Date.today - 1.days
      content_tag(:span, "NEW", :class => "label label-success")
    elsif course.updated_at >= Date.today - 1.days
      content_tag(:span, "MOD", :class => "label label-warning")
    end
  end

  def render_course_admin_name(course)
    link_to course.name, admin_course_path(course)
  end

  def find_version_author_name(version)
    user = User.find_version_author(version)
    user ? user.name : ''
  end

  def diff(content1, content2)
    changes = Diffy::Diff.new(content1, content2,
                              include_plus_and_minus_in_html: true,
                              include_diff_info: true)
    changes.to_s.present? ? changes.to_s(:html).html_safe : 'No Changes'
  end
end
