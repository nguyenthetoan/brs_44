class UsersController < ApplicationController
  before_action :logged_in_user, except: [:new, :create, :show]
  before_action :correct_user, only: [:edit, :update]
  before_action :load_user, only: :show

  def new
    @user = User.new
  end

  def create
    @user = User.create user_params
    if @user.save
      log_in @user
      flash[:success] = t "done_sign_up"
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @favorites = @user.favorites.latest
    @followers = @user.followers.paginate page: params[:page]
    @followings = @user.following.paginate page: params[:page]
    @activities = @user.activities.latest.limit(Settings.activities.max_retrived_feed)
    @user_bookmarks = current_user.bookmarks
  end

  private
  def user_params
    params.require(:user).permit :name, :email, :password, :password_confirmation
  end
  def correct_user
    redirect_to root_url unless User.find_by(id: params[:id]).is_user? current_user
  end

end
