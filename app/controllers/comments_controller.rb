class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :destroy]
  before_action :authenticate_user!, only: [:create, :new, :destroy]

  def index
    @comments = Comment.all
  end

  def new
    @comment = Comment.new(parent_id: params[:parent_id])
  end

  def create
    @project = Project.find(params[:project_id])

    @comment = @project.comments.create(comment_params)
    @comment.user = current_user

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

  def show
  end

  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to project_comments_url, notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end


    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:text, :parent_id)
    end

end
