class BulletsController < ApplicationController
  before_action :set_bullet, only: [:edit, :update, :destroy]
  load_and_authorize_resource

  def new
    @bullet = Bullet.new
  end

  def create
    @bullet = Bullet.create(bullet_params)

    if @bullet.save
      redirect_to :root, notice: '公告已新增！'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @bullet.update(bullet_params)
      redirect_to :root, notice: '公告修改成功'
    else
      render :edit
    end
  end

  def destroy
    @bullet.destroy
    redirect_to :root, alert: '公告已刪除'
  end

  private

  def set_bullet
    @bullet = Bullet.find(params[:id])
  end

  def bullet_params
      params.require(:bullet).permit(:title, :content)
  end
end
