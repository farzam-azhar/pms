class ChartsController < ApplicationController
  def current_month_earnings
    render json: Project.current_month_earnings
  end

  def current_month_time_logs
    render json: Project.current_month_time_logs
  end

  def by_month_earnings
    render json: Project.by_month_earnings
  end

  def by_month_logs
    render json: Project.by_month_logs
  end
end
