class HomeController < ApplicationController
  
  def index
    @bullets = Bullet.all
  end
end
