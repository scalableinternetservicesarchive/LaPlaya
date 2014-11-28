class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper Starburst::AnnouncementsHelper

  def sign_in_path
    '/users/sign_in'
  end

  def access_denied_handler(exception)
    if exception.is_a? CanCan::AccessDenied
      log_exception "CanCan access denied on #{exception.action} #{exception.subject.inspect}", exception
    else
      log_exception exception.message, exception
    end
    respond_to do |format|
      format.html do
        # Just give a generic error message. We don't want to tell people more than they need to know.
        redirect_to root_path, alert: 'You are not authorized to access that page'
      end
      format.js do
        head :forbidden
      end
      format.json do
        head :forbidden
      end
    end
  end

  rescue_from CanCan::AccessDenied, with: :access_denied_handler

  rescue_from ActiveRecord::RecordNotFound, with: :access_denied_handler


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


  private
  def log_exception(message, exception)
    user_id = (current_user && current_user.id).to_s || 'nil'
    logger.info "#{message}, {requestURL #{request.path}, currentUserID #{user_id}}"
    NewRelic::Agent.notice_error(exception, uri: request.path, user_id: user_id)
  end

end
