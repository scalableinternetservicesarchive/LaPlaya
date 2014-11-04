class StaticPagesController < ApplicationController

  def home
    @force_show_signup = params[:signin] == 'true'
  end

end
