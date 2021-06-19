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
        session[:current_user] = @user.id
        redirect_to admin_users_path, notice: '會員註冊成功'
      else
        render :new, notice: '會員註冊失敗'
      end
    end

    def edit; end

    def update
      if @user.update(user_params)
        redirect_to admin_users_path, notice: '修改會員資料成功'
      else
        render :edit, notice: '修改會員資料失敗'
      end
    end

    def destroy
      if @user.destroy
        redirect_to admin_users_path, notice: '使用者已移除'
      else
        redirect_to admin_users_path, notice: '使用者移除失敗'
      end
    end

    def show
      service = MissionsQueryService.new(current_user: @user, params: params)
      @query = service.query
      @missions = service.result
    end

    private

    def user_params
      params.require(:user).permit(:name, :email, :password)
    end

    def find_user
      @user = User.find(params[:id])
    end
  end
end
