class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_project, only: [:new, :create]
  before_action :find_comment, only: [:edit, :update, :destroy]
  before_action :validate_user, only: [:edit, :update, :destroy]
  respond_to :html, :js

  def new
    @comment = Comment.new
    respond_to do |format|
      format.js { render 'shared/new', locals: { object: @comment, modal: 'comment-modal-on-project-index', project: @project } }
    end
  end

  def create
    @check = params[:name] == 'latest_comment' ? true : false
    @comment = @project.comments.build(comment_params)
    @comment.signed_in_user = current_user
    @comment.save
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

    def find_project
      @project = Project.find params[:project_id]
    end
end
