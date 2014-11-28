class Users::RegistrationsController < Devise::RegistrationsController
  before_filter :configure_permitted_parameters

  def preregistration
    respond_to do |format|
      format.js do
        js false
        session['devise.user_attributes'] = params.require(:user).permit(:email, :password, :password_confirmation)
      end
    end
  end

  def check_username
    respond_to do |format|
      format.json do
        username = params[:username]
        render json: User.username_is_valid?(username)
      end
    end
  end

  def check_email
    respond_to do |format|
      format.json do
        email = params[:email]
        render json: User.email_is_valid?(email)
      end
    end
  end

  def check_password
    respond_to do |format|
      format.json do
        password = params[:password]
        render json: User.password_is_valid?(password)
      end
    end
  end

  def respond_with(*resources, &block)
    if resources[0] && resources[0].is_a?(User)
      user = resources[0]
      if user.persisted?
        options = resources.extract_options!
        if options[:location]
          return redirect_to options[:location]
        end
      end
    end
    super
  end

  private
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up).push(:username)
  end


end