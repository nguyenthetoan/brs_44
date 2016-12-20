class ActivitiesController<ApplicationController
  before_action :load_user

  def index
    @activities = Activity.where(user: @user)
    respond_to do |format|
      format.html {render @activities.latest}
    end
  end
end
