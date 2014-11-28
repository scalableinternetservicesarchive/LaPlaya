class StaticPagesController < ApplicationController

  def home

    @force_show_signin = params[:signin] == 'true' || request.path == new_user_session_path
    @force_show_signup = params[:signup] == 'true'

    @projects = Project.all.order(updated_at: :desc).limit(8)
    @galleries = Gallery.all.order(updated_at: :desc).limit(8)
    flash.now['notice'] = 'test'

  end

  def upgrade
  end

end
