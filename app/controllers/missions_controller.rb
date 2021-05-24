class MissionsController < ApplicationController
  before_action :find_mission, only: %i[edit update destroy]

  def index
    @missions = Mission.all
  end

  def new
    @mission = Mission.new
  end

  def create
    @mission = Mission.new(mission_params)

    if @mission.save
      redirect_to root_path, notice: '新增任務成功'
    else
      flash.now[:notice] = '任務新增失敗'
      render :new
    end
  end

  def edit; end

  def update
    if @mission.update(mission_params)
      redirect_to root_path, notice: '任務更新成功'
    else
      flash.now[:notice] = '任務更新失敗'
      render :edit
    end
  end

  def destroy
    if @mission.destroy
      redirect_to root_path, notice: '任務已刪除'
    else
      redirect_to root_path, notice: '任務刪除失敗'
    end
  end

  private

  def mission_params
    params.require(:mission).permit(:title, :content, :started_at, :ended_at)
  end

  def find_mission
    @mission = Mission.find(params[:id])
  end
end
