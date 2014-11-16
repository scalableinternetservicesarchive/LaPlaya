class Users::RegistrationsController < Devise::RegistrationsController
  before_filter :configure_permitted_parameters

  def preregistration
    respond_to do |format|
      format.js do
        js false
        session['devise.auth_method'] = 'password'
        session['devise.preregistration'] = params.require(:user).permit(:email, :password, :password_confirmation)
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

  def create
    build_resource(sign_up_params)

    resource_saved = resource.save
    yield resource if block_given?
    if resource_saved
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_flashing_format?
        sign_up(resource_name, resource)
        respond_to do |format|
          format.js do
            render js: "window.location=\"#{after_sign_up_path_for(resource)}\";"
          end
          format.html do
            redirect_to after_sign_up_path_for(resource)
          end
        end
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
        expire_data_after_sign_in!
        respond_to do |format|
          format.js do
            render js: "window.location=\"#{after_inactive_sign_up_path_for(resource)}\";"
          end
          format.html do
            redirect_to after_inactive_sign_up_path_for(resource)
          end
        end
      end
    else
      clean_up_passwords resource
      @validatable = devise_mapping.validatable?
      if @validatable
        @minimum_password_length = resource_class.password_length.min
      end
      respond_to do |format|
        format.js do
          @new_user = resource
          js false
          render status: 422
        end
        format.json do
          respond_with resource
        end
        format.html do
          @force_show_finish = true
          @new_user = resource
          render 'static_pages/home', status: 422
        end
      end
    end
  end


  private
  def sign_up_params
    if session['devise.auth_method'] == 'password'
      params = super.to_hash
      prereg_params = session['devise.preregistration']
      if prereg_params.is_a? Hash
        params.reverse_merge!(prereg_params)
      end
      params
    else
      super
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up).push(:username)
  end


end