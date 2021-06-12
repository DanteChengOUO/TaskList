# frozen_string_literal: true

class MissionsController < ApplicationController
  before_action :find_mission, only: %i[edit update destroy]

  def index
    @query = Mission.ransack(params[:q])
    @query.sorts = sorts_builder(params)
    flash.now[:notice] = t('.failure') unless valid_params?(params)
    @missions = @query.result.page(params[:page])
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

  def sorts_builder(params)
    return "#{params[:field]} #{params[:order]}" if valid_field?(params[:field]) && valid_order?(params[:order])

    'created_at desc'
  end

  def valid_field?(field)
    valid_fields = %w[created_at ended_at priority]
    return true if valid_fields.include?(field)

    false
  end

  def valid_order?(order)
    valid_orders = %w[ASC DESC]
    return true if valid_orders.include?(order)

    false
  end

  def valid_params?(params)
    return true if params[:order].nil? && params[:field].nil?
    return true if valid_field?(params[:field]) && valid_order?(params[:order])

    false
  end
end
