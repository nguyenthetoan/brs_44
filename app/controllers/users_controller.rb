class UsersController < ApplicationController
  before_action :load_user, only: :show

  def show
    @favorites = @user.favorites.latest
    @followers = @user.followers.paginate page: params[:page]
    @followings = @user.following.paginate page: params[:page]
    @activities = @user.activities.latest.limit(Settings.activities.max_retrived_feed)
    @user_bookmarks = current_user.bookmarks if signed_in?
  end

end
