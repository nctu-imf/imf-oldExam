class Admin::CoursesController < ApplicationController
  before_action :authorize_resource

  def index
    @courses = Course.order("created_at DESC").paginate(:per_page => 15, :page => params[:page])
  end

  def show
    @course = Course.find(params[:id])
  end

  private

  def authorize_resource
    authorize! :manage, :all
  end
end
