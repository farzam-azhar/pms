class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_comment, only: [:edit, :update, :destroy]
  before_action :validate_user, only: [:edit, :update, :destroy]
  respond_to :html, :js

  def create
    @project = Project.find params[:project_id]
    @comment = @project.comments.create(comment_params)
    respond_with @comment
  end

  def edit
    respond_to do |format|
      format.js { render 'shared/edit', locals: { object: @comment, modal: 'comment-modal', project: nil } }
    end
  end

  def update
    @comment.update(comment_params)
    respond_to do |format|
      format.js {
        render 'shared/update',
        locals: {
          object: @comment,
          error_div: 'comment-errors',
          modal: 'comment-modal',
          object_row: "comment-row-#{@comment.id}"
        }
      }
    end
  end

  def destroy
    @comment.destroy
    respond_to do |format|
      format.js {
        render 'shared/destroy',
        locals: {
          object: @comment,
          error_div: 'comment-errors',
          object_row: "comment-row-#{@comment.id}"
        }
      }
    end
  end

  private

    def comment_params
      params.require(:comment).permit(:content).merge(user: current_user)
    end

    def find_comment
      @comment = Comment.find params[:id]
    end

    def validate_user
      redirect_to project_path(@comment.project), alert: 'You are not authorized to perform this action.' if !@comment.valid_user?(current_user)
    end
end
