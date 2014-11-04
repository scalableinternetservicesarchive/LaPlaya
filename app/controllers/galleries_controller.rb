class GalleriesController < ApplicationController
  before_action :set_gallery, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:create, :edit, :new, :update, :destroy]
  respond_to :html, :json

  def index
    @galleries = Gallery.all
    respond_with(@galleries)
  end

  def show
    respond_with(@gallery)
  end

  def new
    @gallery = Gallery.new
    respond_with(@gallery)
  end

  def edit
  end

  def create
    @gallery = Gallery.new(gallery_params)
    @gallery.user = current_user
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
    def set_gallery
      @gallery = Gallery.find(params[:id])
    end

    def gallery_params
      params.require(:gallery).permit(:title)
    end
end
