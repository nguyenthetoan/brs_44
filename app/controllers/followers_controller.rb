class FollowersController < ApplicationController
  before_action :authenticate_user!, :load_user

  def index
    @followers = @user.followers.paginate page: params[:page]
    respond_to do |format|
      format.html {render partial: "follower", collection: @followers}
    end
  end
end
