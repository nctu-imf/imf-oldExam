class Admin::CoursesController < ApplicationController

  def index
    @courses = Course.order("created_at DESC").paginate(:per_page => 15, :page => params[:page])

    authorize! :manage, :all
  end

end