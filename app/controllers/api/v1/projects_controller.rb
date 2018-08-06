class Api::V1::ProjectsController < ApiController
  before_action :find_project, only: [:show]

  def index
    @projects = Project.all
    render json: @projects
  end

  def show
    render json: @project, include: ['client']
  end

  def search
    @projects = Project.search(params[:title], params[:client_name], params[:assigned_user_name], params[:description])
    render json: @projects, include: ['client']
  end

  private

    def find_project
      @project = Project.find params[:id]
    end
end
