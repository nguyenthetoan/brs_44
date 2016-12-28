class Admin::ImportController < ApplicationController
  before_action :authenticate_user!

  def create
    @importable = load_importable params[:object]
    if params[:file]
      ImportService.new(@importable).import params[:file]
      flash[:notice] = t "done_import"
      redirect_back fallback_location: :back
    end
  end

end
