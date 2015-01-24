class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @courses = @user.courses
  end
end
