class FollowingsController < ApplicationController
  before_action :authenticate_user!, :load_user

  def show
    @followings = @user.following.paginate page: params[:page]
  end
end
