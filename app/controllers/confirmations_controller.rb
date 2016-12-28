class ConfirmationsController < Devise::ConfirmationsController

  def create
    super
  end

  def new
    super
  end

  def show
    super
  end

  protected

  def after_confirmation_path_for _resource_name, _resource
    signed_in?(_resource) ? user_path(_resource) : new_user_session_path
  end

end
