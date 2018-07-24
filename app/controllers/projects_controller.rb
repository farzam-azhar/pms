class ProjectsController < ApplicationController
  before_action :set_project, only: [:destroy, :edit, :update, :show]
  respond_to :html, :js

  def index
    @projects = Project.all
  end

  def new
    @project = Project.new
    respond_with @project
  end

  def create
    @project = Project.create(project_params)
    respond_with @project
  end

  def show
  end

  def edit
    respond_with @project
  end

  def update
    @project.update_attributes(project_params)
    respond_with @project
  end

  def destroy
    if @project.destroy
      respond_with @project
    else
      redirect_to projects_path, alert: "Something went Wrong while Deleting Project"
    end
  end

  private

    def project_params
      params.require(:project).permit(:title, :estimated_price, :end_date, :description, :client_id)
    end

    def set_project
      @project = Project.find params[:id]
    end
end
