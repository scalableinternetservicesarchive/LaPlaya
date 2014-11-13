class GalleriesController < ApplicationController
  check_authorization
  load_resource
  authorize_resource only: Ability::RESTFUL_ACTIONS
  respond_to :html, :json

  def index
    respond_with(@galleries)
  end

  def show
    @projects = @gallery.projects
    respond_with(@gallery)
  end

  def new
    @projects = Project.all
    respond_with(@gallery)
  end

  def edit
  end

  def create
    @gallery.author = current_user
    @gallery.save
    respond_with(@gallery)
  end

  def update
    @gallery.update(gallery_params)
    respond_with(@gallery)
  end

  def destroy
    @gallery.destroy
    respond_with(@gallery)
  end

  private
    def gallery_params
      params.require(:gallery).permit(:title,project_ids: [])
    end
end
