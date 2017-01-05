class CallbacksController < ApplicationController

  def facebook
    @user = User.from_omniauth(request.env["omniauth.auth"])
    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
    else
      session["devise.facebook_date"] = request.env["omniauth.auth"]
      redirect_to signup_path
    end
  end

  def failure
    redirect_to root_path
  end

end
