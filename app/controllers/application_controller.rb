class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exception|
    flash[:danger] = exception.message
    redirect_to root_url
  end
  rescue_from ActiveRecord::RecordNotFound, with: :render_404

  require "will_paginate/array"

  before_action :configure_permitted_parameters, if: :devise_controller?

  include ApplicationHelper

  private
  def render_404
    render file: "public/404", layout: false, status: :not_found
  end

  def admin_user
    redirect_to root_url unless current_user.admin?
  end

  def load_user
    @user = User.friendly.find params[:id]
  end

  def load_book
    @book = Book.friendly.find params[:id]
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit :sign_up, keys: [:name, :email, :password, :password_confirmation]
  end

end
