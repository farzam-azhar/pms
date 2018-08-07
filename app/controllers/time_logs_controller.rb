class TimeLogsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :destroy, :update]
  before_action :find_time_log, only: [:edit, :update, :destroy]
  before_action :get_projects, only: [:edit, :new]
  respond_to :html, :js

  def index
    @time_logs = TimeLog.all
    authorize @time_logs
  end

  def new
    @time_log = TimeLog.new
    authorize @time_log
    respond_to do |format|
      format.js { render 'shared/edit', locals: { object: @time_log, modal: 'time-log-modal', project: @projects } }
    end
  end

  def create
    @time_log = current_user.time_logs.create(time_log_params)
    authorize @time_log
    respond_to do |format|
      format.js {
        render 'shared/create',
        locals: {
          object: @time_log,
          error_div: 'time-logs-error',
          modal: 'time-log-modal',
          objects_div: 'time-logs',
          object_row: "time-log-row-#{@time_log.id}"
        }
      }
    end
  end

  def edit
    respond_to do |format|
      format.js { render 'shared/edit', locals: { object: @time_log, modal: 'time-log-modal', project: @projects } }
    end
  end

  def update
    @time_log.update(time_log_params)
    respond_to do |format|
      format.js {
        render 'shared/update',
        locals: {
          object: @time_log,
          error_div: 'time-logs-error',
          modal: 'time-log-modal',
          object_row: "time-log-row-#{@time_log.id}"
        }
      }
    end
  end

  def destroy
    @time_log.destroy
    respond_to do |format|
      format.js {
        render 'shared/destroy',
        locals: {
          object: @time_log,
          error_div: 'time-logs-error',
          object_row: "time-log-row-#{@time_log.id}"
        }
      }
    end
  end

  private
    def time_log_params
      params.require(:time_log).permit(:start_time, :end_time, :project_id)
    end

    def find_time_log
      @time_log = TimeLog.find params[:id]
      authorize @time_log
    end

    def get_projects
      @projects = current_user.get_projects
    end
end
