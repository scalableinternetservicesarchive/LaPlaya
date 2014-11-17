class StaticPagesController < ApplicationController

  def home
    @force_show_signin = params[:signin] == 'true'
    @force_show_signup = params[:signup] == 'true'

    @projects = Project.all.order(updated_at: :desc).limit(8)
    @galleries = Gallery.all.order(updated_at: :desc).limit(8)

  end

end
