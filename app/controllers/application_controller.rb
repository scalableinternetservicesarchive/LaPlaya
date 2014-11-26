class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def sign_in_path
    '/users/sign_in'
  end

  def access_denied_handler(exception)
    log_exception "Access denied on #{exception.action} #{exception.subject.inspect}", exception
    respond_to do |format|
      format.html do
        redirect_to root_path, alert: exception.message
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
