class PagesController < ApplicationController
  def about
    @grades = Grade.all    
  end
end
