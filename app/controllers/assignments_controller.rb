class AssignmentsController < ApplicationController
  before_action :find_project
  before_action :find_assignment, only: [:edit, :update, :destroy]
  respond_to :html, :js

  def new
    @assignment = @project.assignments.build
    respond_with @assignment
  end

  def create
    @assignment = @project.assignments.create(assignment_params)
    respond_with @assignment
  end

  def edit
    respond_with @assignment
  end

  def update
    @assignment.update(assignment_params)
    respond_with @assignment
  end

  def destroy
    if @assignment.destroy
      respond_with @assignment
    else
      redirect_to project_path(@project), alert: "Something went Wrong while removing user from this Project"
    end
  end

  private

    def find_project
      @project = Project.find params[:project_id]
    end

    def find_assignment
      @assignment = Assignment.find params[:id]
    end

    def assignment_params
      params.require(:assignment).permit(:user_id, :role)
    end
end
