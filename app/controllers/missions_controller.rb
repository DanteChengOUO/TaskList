class MissionsController < ApplicationController
  def index
    @missions = Mission.all
  end

  def new
    @mission = Mission.new
  end

  def create
    @mission = Mission.new(mission_params)

    if @mission.save
      redirect_to root_path, notice: "新增任務成功"
    else
      render :new
    end
  end

  def show
  end

  def edit
    @mission = Mission.find(params[:id])
  end

  def update
    @mission = Mission.find(params[:id])
    if @mission.update(mission_params)
      redirect_to root_path, notice: "任務更新成功"
    else
      render :edit, notice: "任務更新失敗"
    end
  end

  def destroy
    @mission = Mission.find(params[:id])
    @mission.destroy
    redirect_to root_path, notice: "任務已刪除"
  end

  private

  def mission_params
    params.require(:mission).permit(:title, :content, :started_at, :ended_at)
  end
end
