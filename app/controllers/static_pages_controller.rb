class StaticPagesController < ApplicationController

  def home
    @force_show_signin = params[:signin] == 'true'
    @force_show_signup = params[:signup] == 'true'
  end

end
