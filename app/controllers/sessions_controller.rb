# frozen_string_literal: true

class SessionsController < ApplicationController
  def new
    redirect_to missions_path if session[:current_user_id].present?
  end

  def create
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      session[:current_user_id] = user.id
      redirect_to missions_path, notice: "歡迎#{user.name} 登入成功"
    else
      redirect_to root_path, notice: '登入失敗'
    end
  end
end
