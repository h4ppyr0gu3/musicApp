class OmniauthController < Devise::OmniauthCallbacksController

	def facebook
    @user = User.create_from_provider(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in_and_redirect @user
    else
      redirect_to root_path
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
      redirect_to root_path
    end
  end

end