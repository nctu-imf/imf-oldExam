class VersionsController < ApplicationController
  before_action :set_course_and_version

  def rollback
    course = @version.reify
    @version.reify.save
    redirect_to admin_course_path(course)
  end

  def diff
  end

  private

  def set_course_and_version
    @course = Course.find(params[:course_id])
    @version = @course.versions.find(params[:id])
  end
end
