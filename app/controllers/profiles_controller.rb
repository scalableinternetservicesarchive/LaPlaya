class ProfilesController < ApplicationController

  def show
    @user = User.find(params[:id])
    @projects = @user.projects
  end

end