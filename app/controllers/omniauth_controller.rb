class OmniauthController < Devise::OmniauthCallbacksController

	def facebook
    @user = User.create_from_provider(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in_and_redirect @user
    else
      # session["devise.facebook_data"] = request.env["omniauth.auth"].except(:extra) # Removing extra as it can overflow some session stores
      redirect_to new_user_registration_url
    end
  end

  def failure
    redirect_to root_path
  end

  def google_oauth2
    @user = User.create_from_provider(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in_and_redirect @user
    else
      # session["devise.facebook_data"] = request.env["omniauth.auth"].except(:extra) # Removing extra as it can overflow some session stores
      redirect_to new_user_registration_url
    end
  end

end