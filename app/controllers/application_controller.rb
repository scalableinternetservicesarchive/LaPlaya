class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def sign_in_path
    '/users/sign_in'
  end

  def sample_gallery_items
    [
        OpenStruct.new(
            {
                title: 'A Graphic Design Item',
                thumbnail: '/solid/img/portfolio/portfolio_09.jpg',
                url: '/solid/single-project.html'
            }),
        OpenStruct.new(
            {
                title: 'A Web Design Item',
                thumbnail: '/solid/img/portfolio/portfolio_02.jpg',
                url: '/solid/single-project.html'
            }),
        OpenStruct.new(
            {
                title: 'A Graphic Design Item',
                thumbnail: '/solid/img/portfolio/portfolio_03.jpg',
                url: '/solid/single-project.html'
            }),
        OpenStruct.new(
            {
                title: 'A Graphic Design Item',
                thumbnail: '/solid/img/portfolio/portfolio_04.jpg',
                url: '/solid/single-project.html'
            }),
        OpenStruct.new(
            {
                title: 'A Graphic Design Item',
                thumbnail: '/solid/img/portfolio/portfolio_05.jpg',
                url: '/solid/single-project.html'
            })
    ]
  end

end
