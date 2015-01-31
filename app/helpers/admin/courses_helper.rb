module Admin::CoursesHelper
  def render_course_version_editor(version)
    content_tag(:span, User.find(version.whodunnit).name, class: "label label-danger")
  end
end
