class Admin::UsersController < ApplicationController
  before_action :authenticate_user!, :admin_user

  load_and_authorize_resource except: [:create]

  layout "admin"

  def index
    @users = User.paginate page: params[:page], per_page: Settings.item_per_page
  end

  def new
    @user = User.new
    respond_to do |format|
      format.html{render partial: "user_form", locals: {user: @user}}
    end
  end

  def create
    @user = User.new user_params
    if params[:skip_confirmation] == "1"
      @user.skip_confirmation!
    end
    if @user.save
      flash[:notice] = t "user_created"
      redirect_back fallback_location: :back
    else
      flash[:alert] = t "user_create_failed"
      redirect_back fallback_location: :back
    end
  end

  def show
    respond_to do |format|
      format.html{render partial: "edit", locals: {user: @user}}
    end
  end

  def update
    @user = User.find_by id: params[:id]
    result = false
    if params[:user][:password].blank?
      result = @user.update_without_password user_params
    else
      result = @user.update_attributes user_params
    end
    if result
      flash[:notice] = t "user_updated"
      redirect_back fallback_location: :back
    else
      flash[:alert] = t "user_update_failed"
      redirect_back fallback_location: :back
    end
  end

  private
  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation, :role
  end

end
