class TimeLogsController < ApplicationController
  before_action :find_time_log, only: [:edit, :update, :destroy]
  respond_to :html, :js

  def index
    @time_logs = TimeLog.all
  end

  def new
    @time_log = TimeLog.new
    respond_with @time_log
  end

  def create
    @time_log = current_user.time_logs.create(time_log_params)
    respond_with @assignment
  end

  def edit
    respond_with @time_log
  end

  def update
    @time_log.update(time_log_params)
    respond_with @time_log
  end

  def destroy
    @time_log.destroy
    respond_with @time_log
  end

  private
    def time_log_params
      params.require(:time_log).permit(:start_time, :end_time, :project_id)
    end

    def find_time_log
      @time_log = TimeLog.find params[:id]
    end
end
