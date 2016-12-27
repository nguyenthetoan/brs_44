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

  # The path used after resending confirmation instructions.
  # def after_resending_confirmation_instructions_path_for(resource_name)
  #   super(resource_name)
  # end

  def after_confirmation_path_for(resource_name, resource)
    if signed_in?(resource)
      user_path(resource)
    else
      new_user_session_path
    end
  end

end
