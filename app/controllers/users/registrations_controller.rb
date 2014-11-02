class Users::RegistrationsController < Devise::SessionsController

  def check_username
    respond_to do |format|
      format.json do
        username = params[:username]
        response = {username: username}
        if username_is_valid?(username, response)
          if User.where(username: username).count == 0
            response[:status] = :available
          else
            response[:status] = :taken
          end
        end
      end
    end
  end

  def check_email
    respond_to do |format|
      format.json do
        email = params[:email]
        response = {email: email}
        if email_is_valid?(email, response)
          if User.where(email: email).count == 0
            response[:status] = :available
          else
            response[:status] = :taken
          end
        end
        render json: response
      end
    end
  end

  private
  def username_is_valid?(username, response)
    if username.blank?
      response[:status] = :blank
      false
    else
      true
    end
  end

  def email_is_valid?(email, response)
    if email.blank?
      response[:status] = :blank
      false
    else
      true
    end
  end

end