class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  require "will_paginate/array"
  before_action :configure_permitted_parameters, if: :devise_controller?

  include ApplicationHelper

  private
  def logged_in_user
    unless signed_in?
      flash[:danger] = t "req_login"
      redirect_to login_path
    end
  end

  def render_404
    render file: "public/404", layout: false, status: :not_found
  end

  def admin_user
    redirect_to root_url unless current_user.admin?
  end

  def load_user
    @user = User.find_by id: params[:id]
    @user ? @user : render_404
  end

  def load_book
    @book = Book.find_by id: params[:id]
    @book ? @book : render_404
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit :sign_up, keys: [:name, :email, :password, :password_confirmation]
  end
end
