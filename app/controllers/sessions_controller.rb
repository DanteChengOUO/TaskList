# frozen_string_literal: true

class SessionsController < ApplicationController
  def new
    redirect_to admin_users_path if session[:current_user_id].present?
  end

  def create
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      session[:current_user_id] = user.id
      redirect_to admin_users_path, notice: t('.success', name: user.name)
    else
      redirect_to login_path, notice: t('.failure')
    end
  end

  def destroy
    return redirect_to admin_user_path, notice: t('.failure') if session[:current_user_id].blank?

    session[:current_user_id] = nil
    redirect_to login_path, notice: t('.success')
  end
end
