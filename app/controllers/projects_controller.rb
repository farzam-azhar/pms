class ProjectsController < ApplicationController
  before_action :set_project, only: [:destroy, :edit, :update, :show, :mark_completed]
  respond_to :html, :js

  def index
    @projects = Project.all.page(params[:page]).per(Project::PER_PAGE)
  end

  def new
    @project = Project.new
    respond_to do |format|
      format.js { render 'shared/edit', locals: { object: @project, modal: 'project-modal', project: nil } }
    end
  end

  def create
    @project = Project.create(project_params)
    respond_to do |format|
      format.js {
        render 'shared/create',
        locals: {
          object: @project,
          error_div: 'project-error',
          modal: 'project-modal',
          objects_div: 'projects',
          object_row: "project-#{@project.id}"
        }
      }
    end
  end

  def show
    respond_to do |format|
      format.html
      format.pdf do
        send_data @project.pdf(view_context).render,
                  filename: "Project-#{@project.id}.pdf",
                  type: "application/pdf",
                  disposition: "inline"
      end
    end
  end

  def edit
    respond_to do |format|
      format.js { render 'shared/edit', locals: { object: @project, modal: 'project-modal', project: nil } }
    end
  end

  def update
    @project.update_attributes(project_params)
    respond_to do |format|
      format.js {
        render 'shared/update',
        locals: {
          object: @project,
          error_div: 'project-error',
          modal: 'project-modal',
          object_row: "project-#{@project.id}"
        }
      }
    end
  end

  def mark_completed
    @project.completed!
    respond_to do |format|
      format.js {
        render 'shared/destroy',
        locals: {
          object: @project,
          error_div: 'project-error',
          object_row: "project-#{@project.id}"
        }
      }
    end
  end

  private

    def project_params
      params.require(:project).permit(:title, :estimated_price, :end_date, :description, :client_id, :status, attachments_attributes: [:id, :data, :_destroy])
    end

    def set_project
      @project = Project.find params[:id]
    end
end
