# frozen_string_literal: true

class MissionsQueryService
  attr_reader :current_user, :params, :query

  def initialize(**options)
    @current_user = options.fetch(:current_user)
    @params = options.fetch(:params)
    @query = current_user&.missions&.ransack(params[:q])
  end

  def result
    query.sorts = sorts_builder(params)
    query.result.page(params[:page]).includes(:user)
  end

  def valid_params?
    return true if params[:order].nil? && params[:field].nil?
    return true if valid_field?(params[:field]) && valid_order?(params[:order])

    false
  end

  private

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
end
