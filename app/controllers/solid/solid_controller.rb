class Solid::SolidController < ApplicationController

  def index
    flash[:notice] = 'helloworld'
    js :portfolio
  end

  def about
  end

  def contact
  end

  def blog
  end

  def portfolio
  end

  def single_post
  end

  def single_project
    js :portfolio
  end

end