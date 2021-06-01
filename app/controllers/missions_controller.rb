# frozen_string_literal: true

class MissionsController < ApplicationController
  before_action :find_mission, only: %i[edit update destroy]

  def index
    sort_mission
  end

  def new
    @mission = Mission.new
  end

  def create
    @mission = Mission.new(mission_params)

    if @mission.save
      redirect_to root_path, notice: t('.success')
    else
      flash.now[:notice] = t('.failure')
      render :new
    end
  end

  def edit; end

  def update
    if @mission.update(mission_params)
      redirect_to root_path, notice: t('.success')
    else
      flash.now[:notice] = t('.failure')
      render :edit
    end
  end

  def destroy
    if @mission.destroy
      redirect_to root_path, notice: t('.success')
    else
      redirect_to root_path, notice: t('.failure')
    end
  end

  private

  def mission_params
    params.require(:mission).permit(:title, :content, :started_at, :ended_at)
  end

  def find_mission
    @mission = Mission.find(params[:id])
  end

  def sort_mission
    case params[:field]
    when 'created_at' then @missions = Mission.order(created_at: params[:order])
    when nil then @missions = Mission.order(created_at: :DESC)
    else
      flash.now[:notice] = '僅提供預設排序'
      @missions = Mission.order(created_at: :DESC)
    end
  end
end
