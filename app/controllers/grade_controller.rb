class GradeController < ApplicationController
  def show
    @grades = Grade.all
    @grade = Grade.find(params[:id])
    @courses = @grade.courses.order('year desc')
  end
end
