class RelationshipsController < ApplicationController
  before_action :logged_in_user

  def create
    @user = User.find_by id: params[:followed_id]
    current_user.follow @user
    current_user.activities.create(activatable: @user, action_type: :start_follow)
    respond_to do |format|
      format.html {render partial: "users/unfollow"}
    end
  end

  def destroy
    @user = Relationship.find_by(id: params[:id]).followed
    current_user.unfollow @user
    current_user.activities.create(activatable: @user, action_type: :unfollowed)
    respond_to do |format|
      format.html {render partial: "users/follow"}
    end
  end
end
