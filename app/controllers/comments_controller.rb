class CommentsController < ApplicationController
  check_authorization
  load_resource
  authorize_resource only: Ability::RESTFUL_ACTIONS

  def new
    @comment = Comment.new(parent_id: params[:parent_id])
  end

  def create
    @project = Project.find(params[:project_id])

    @comment = @project.comments.create(comment_params)
    @comment.author = current_user
    @comment.deleted = false

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

end
