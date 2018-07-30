class AssignmentsController < ApplicationController
  before_action :find_project
  before_action :find_assignment, only: [:edit, :update, :destroy]
  respond_to :html, :js

  def new
    @assignment = @project.assignments.build
    respond_to do |format|
      format.js { render 'shared/edit', locals: { object: @assignment, modal: 'assignment-modal', project: @project } }
    end
  end

  def create
    @assignment = @project.assignments.create(assignment_params)
    respond_to do |format|
      format.js {
        render 'shared/create',
        locals: {
          object: @assignment,
          error_div: 'assignment-error',
          modal: 'assignment-modal',
          objects_div: 'assignments',
          object_row: "assigned-user-row-#{@assignment.id}"
        }
      }
    end
  end

  def edit
    respond_to do |format|
      format.js { render 'shared/edit', locals: { object: @assignment, modal: 'assignment-modal', project: @project } }
    end
  end

  def update
    @assignment.update(assignment_params)
    respond_to do |format|
      format.js {
        render 'shared/update',
        locals: {
          object: @assignment,
          error_div: 'assignment-error',
          modal: 'assignment-modal',
          object_row: "assigned-user-row-#{@assignment.id}"
        }
      }
    end
  end

  def destroy
    @assignment.destroy
    respond_to do |format|
      format.js {
        render 'shared/destroy',
        locals: {
          object: @assignment,
          error_div: 'assignment-error',
          object_row: "assigned-user-row-#{@assignment.id}"
        }
      }
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
