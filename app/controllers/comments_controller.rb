class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_comment, only: [:show, :update, :destroy]
  def new
    @comment = Comment.new
    respond_to do |format|
      format.html {render partial: "comment_form", locals: {comment: @comment}}
    end
  end

  def create
    @comment = current_user.comments.build comment_params
    if @comment.save
      current_user.activities.create(activatable: @comment, action_type: :comment_review)
      respond_to do |format|
        format.html {render @comment}
      end
    end
  end

  def show
    respond_to do |format|
      format.html {render partial: "edit", locals: {comment: @comment}}
    end
  end

  def update
    @comment.update_attributes comment_params
    redirect_back fallback_location: :back
  end

  def destroy
    unless @comment.nil?
      @comment.destroy
      respond_to do |format|
        format.html
      end
    end
  end

  private
  def comment_params
    params.require(:comment).permit :content, :review_id
  end

  def load_comment
    @comment = Comment.find_by id: params[:id]
  end

end
