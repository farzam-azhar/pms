class Api::V1::TimeLogsController < ApiController
  def index
    @time_logs = TimeLog.all
    render json: @time_logs, include: ['user', 'project']
  end
end
