class HomeController < ApplicationController

  def index
    @bullets = Bullet.recent
  end
end
