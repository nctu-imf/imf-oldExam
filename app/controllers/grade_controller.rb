class GradeController < ApplicationController
  before_action :authenticate_user!  
  
  def show
    @grades = Grade.all
    @grade = Grade.find(params[:id])
    @courses = @grade.courses.recent
  end
end
