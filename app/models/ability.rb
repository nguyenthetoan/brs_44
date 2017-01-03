class Ability
  include CanCan::Ability

  def initialize user
    user ||= User.new
    if user.admin?
      can :manage, :all
    elsif user.user?
      alias_action :create, :read, :update, :destroy, to: :crud
      can :read, :all
      can :crud, [Review, Comment, Favorite, Like, Relationship, Request, Bookmark], user_id: user.id
    else
      can :read, :all
    end
  end
end
