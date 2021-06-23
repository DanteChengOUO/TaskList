# frozen_string_literal: true

class MissionsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_mission, only: %i[edit update destroy]

  def index
    service = MissionsQueryService.new(current_user: current_user, params: params)
    @query = service.query
    @missions = service.result
    flash.now[:notice] = t('.failure') unless service.valid_params?
  end

  def new
    @mission = Mission.new
  end

  def create
    @mission = Mission.new(mission_params)

    if @mission.save
      redirect_to missions_path, notice: t('.success')
    else
      flash.now[:notice] = t('.failure')
      render :new
    end
  end

  def edit; end

  def update
    if @mission.update(mission_params)
      redirect_to missions_path, notice: t('.success')
    else
      flash.now[:notice] = t('.failure')
      render :edit
    end
  end

  def destroy
    if @mission.destroy
      redirect_to missions_path, notice: t('.success')
    else
      redirect_to missions_path, notice: t('.failure')
    end
  end

  private

  def authenticate_user!
    redirect_to login_path, notice: t('missions.failure') unless session[:current_user_id]
  end

  def mission_params
    params.require(:mission).permit(:title, :content, :started_at, :ended_at, :status, :priority, :user_id)
  end

  def find_mission
    @mission = Mission.find(params[:id])
  end
end
