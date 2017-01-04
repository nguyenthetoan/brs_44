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

  def parse_datetime_params params, label
    year   = params[(label.to_s + "(1i)").to_sym].to_i
    month  = params[(label.to_s + "(2i)").to_sym].to_i
    mday   = params[(label.to_s + "(3i)").to_sym].to_i
    hour   = (params[(label.to_s + "(4i)").to_sym] || 0).to_i
    minute = (params[(label.to_s + "(5i)").to_sym] || 0).to_i
    second = (params[(label.to_s + "(6i)").to_sym] || 0).to_i
    DateTime.civil_from_format(:local, year, month, mday, hour, minute, second)
  end

end
