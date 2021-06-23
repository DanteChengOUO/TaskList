# frozen_string_literal: true

module Admin
  class UsersController < ApplicationController
    before_action :authenticate_user!, :redirect_when_not_admin, except: %i[new create]
    before_action :find_user, only: %i[show edit update destroy]

    def index
      @user = User.order(:name).page(params[:page]).includes(:missions)
    end

    def new
      @user = User.new
    end

    def create
      @user = User.new(user_params)
      if current_user && @user.save
        redirect_to admin_users_path, notice: t('.success')
      elsif @user.save
        session[:current_user_id] = @user.id
        redirect_to missions_path, notice: t('.success')
      else
        render :new, notice: t('.failure')
      end
    end

    def edit; end

    def update
      if @user.update(user_params)
        redirect_to admin_users_path, notice: t('.success')
      else
        render :edit, notice: t('.failure')
      end
    end

    def destroy
      return redirect_to admin_users_path, notice: t('.self_delete') if @user == current_user

      if @user.destroy
        redirect_to admin_users_path, notice: t('.success')
      else
        redirect_to admin_users_path, notice: t('.failure')
      end
    end

    def show
      service = MissionsQueryService.new(current_user: @user, params: params)
      @query = service.query
      @missions = service.result
    end

    private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :role)
    end

    def find_user
      @user = User.find(params[:id])
    end

    def redirect_when_not_admin
      return if current_user&.admin?

      redirect_to missions_path, notice: t('.authorization')
    end
  end
end
