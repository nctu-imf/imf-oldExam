class GradeController < ApplicationController
  def show
    @grades = Grade.all
    @grade = Grade.find(params[:id])
    @courses = @grade.courses
  end
end
