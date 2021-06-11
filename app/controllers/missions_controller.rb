# frozen_string_literal: true

class MissionsController < ApplicationController
  before_action :find_mission, only: %i[edit update destroy]

  def index
    @query = Mission.ransack(params[:q])

    if valid_order_and_field
      @query.sorts = "#{params[:field]} #{params[:order]}"
    else
      flash.now[:notice] = t('.failure')
    end

    @query.sorts = 'created_at desc'
    @missions = @query.result
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
    params.require(:mission).permit(:title, :content, :started_at, :ended_at, :status, :priority)
  end

  def find_mission
    @mission = Mission.find(params[:id])
  end

  def valid_order_and_field
    valid_orders = ['ASC', 'DESC', nil]
    valid_fields = ['created_at', 'ended_at', 'priority', nil]
    return true if valid_orders.include?(params[:order]) && valid_fields.include?(params[:field])

    false
  end
end
