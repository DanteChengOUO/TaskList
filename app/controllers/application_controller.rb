# frozen_string_literal: true

class ApplicationController < ActionController::Base
  helper_method :current_user

  private

  def current_user
    return unless session[:current_user_id]

    @current_user ||= User.find_by(id: session[:current_user_id])
  end

  def authenticate_user!
    redirect_to login_path, notice: t('.failure') if current_user.blank?
  end
end
