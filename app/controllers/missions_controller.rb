class MissionsController < ApplicationController

  def index
    @mission = Mission.all
  end

  def new
    @mission = Mission.new
  end

  def create
    @mission = Mission.new(clean_mission_params)
    if @mission.save
      redirect_to "/",notice: '新增任務成功'
    else
      render :new
    end
  end
  
  def show
    @mission = Mission.find(params[:id])
  end
  
  def edit
    @mission = Mission.find(params[:id])
  end
  
  def update
    @mission = Mission.find(params[:id])
    @mission.update(clean_mission_params)
    redirect_to missions_path ,notice: '修改成功'
  end

  def destroy
    @mission = Mission.find(params[:id])
    @mission.destroy
    redirect_to missions_path ,notice: '刪除成功'
  end
   
  private
  
  def clean_mission_params
    params.require(:mission).permit(:name ,:sort ,:tag ,:start ,:end ,:context ,:status )
  end
end
