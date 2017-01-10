class UsersController < ApplicationController
  before_action :load_user, only: :show

  def index
    if params[:search]
      @users = User.search(params[:search]).paginate page: params[:page], per_page: Settings.item_per_page
    else
      @users = User.paginate page: params[:page], per_page: Settings.item_per_page
    end
  end

  def show
    @favorites = @user.favorites.latest
    @followers = @user.followers.paginate page: params[:page]
    @followings = @user.following.paginate page: params[:page]
    @activities = @user.activities.latest.limit(Settings.activities.max_retrived_feed)
    @user_bookmarks = current_user.bookmarks if signed_in?
  end

end
