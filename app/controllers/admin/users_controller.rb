# frozen_string_literal: true

module Admin
  class UsersController < ApplicationController
    before_action :authenticate_user!, except: %i[new create]
    before_action :find_user, only: %i[show edit update destroy]

    def index
      @user = User.order(:name).page(params[:page]).includes(:missions)
    end

    def new
      @user = User.new
    end

    def create
      @user = User.new(user_params)

      if @user.save
        session[:current_user_id] = @user.id
        redirect_to admin_users_path, notice: t('.success')
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
      if @user == current_user
        redirect_to admin_users_path, notice: '不能刪除自己'
      elsif @user.destroy
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
  end
end
