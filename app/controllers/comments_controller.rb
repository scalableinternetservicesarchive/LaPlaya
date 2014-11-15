class CommentsController < ApplicationController
  before_action :set_parent_id_to_comment, only: [:new]
  check_authorization
  load_resource :project, only: [:new, :create, :destroy]
  load_resource :comment, through: :project
  authorize_resource :comment, only: Ability::RESTFUL_ACTIONS

  def new
    authorize! :show, @project
  end

  def create
    authorize! :show, @project
    @comment.author = current_user

    respond_to do |format|
      if @comment.save
        format.html { redirect_to project_path(@comment.project), notice: 'Comment was successfully created.' }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @comment.deleted = true
    respond_to do |format|
      if @comment.save
        format.html { redirect_to project_path(@comment.project), notice: 'Comment was successfully deleted.' }
        format.json { head :no_content }
      else
        format.html { redirect_to project_path(@comment.project, @comment), warning: 'There was an error deleting your comment' }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  # Never trust parameters from the scary internet, only allow the white list through.
  def comment_params
    params.require(:comment).permit(:text, :parent_id)
  end

  def set_parent_id_to_comment
    if params[:parent_id]
      params[:comment] ||= {}
      params[:comment][:parent_id] = params.delete(:parent_id)
    end
  end

end
