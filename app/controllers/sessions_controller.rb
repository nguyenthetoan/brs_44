class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user && user.authenticate(params[:session][:password])
      log_in user
      flash[:success] = t ".done_login"
      redirect_to root_path
    else
      flash.now[:danger] = t ".invalid_login"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_path
  end
end
