class LikesController<ApplicationController
  before_action :logged_in_user, only: [:create, :destroy, :show]

  def create
    @like = current_user.likes.build like_params
    if @like.save
      respond_to do |format|
        format.json {render json: @like}
      end
    end
  end

  def destroy
    @like = Like.find_by id: params[:id]
    unless @like.nil?
      @like.destroy
      respond_to do |format|
        format.html
      end
    end
  end

  def show
    @like = Like.find_by id: params[:like_id]
    respond_to do |format|
      format.html {render partial: "shared/like_form", locals: {likable: @like}}
    end
  end

  private
  def like_params
    params.require(:like).permit :likable_type, :likable_id, :like
  end
end
