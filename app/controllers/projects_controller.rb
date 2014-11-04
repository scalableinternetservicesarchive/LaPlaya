class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  respond_to :html, :json

  def index
    @projects = Project.all
  end

  def new
    @project = Project.new
    respond_with(@project)
  end

  def create
    @project = Project.new(project_params)

    @project.user = current_user

    respond_to do |format|
      if @project.save
        format.html {redirect_to @project, notice: 'Project was successfully created'}
        format.json {render :show, status: :created, location: @project }
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end

  end

  def show
  end

  def edit
  end

  def update
    flash[:notice] = "#{@project.title} was successfully updated." if @project.update(project_params)
    respond_with(@project)
  end

  def destroy
    @project.destroy
    flash[:notice] = "#{@project.title} was successfully destroyed."
    respond_with @project
  end

  private

    def set_project
      @project = Project.find(params[:id])
    end

    def project_params
      params.require(:project).permit(:title, :instructions, :about, :thumbnail)
    end

end
