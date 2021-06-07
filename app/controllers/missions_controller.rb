# frozen_string_literal: true

class MissionsController < ApplicationController
  before_action :find_mission, only: %i[edit update destroy]

  def index
    if valid_order?(params[:order])
      sort_missions
    else
      sort_missions_with_notice
    end
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

  def sort_missions
    case params[:field]
    when 'created_at' then @missions = Mission.order(created_at: params[:order])
    when nil then @missions = Mission.order(created_at: :DESC)
    else sort_missions_with_notice
    end
  end

  def valid_order?(order)
    valid_orders = ['ASC', 'DESC', nil]
    return true if valid_orders.include?(order)

    false
  end

  def sort_missions_with_notice
    flash.now[:notice] = t('.failure')
    @missions = Mission.order(created_at: :DESC)
  end
end
