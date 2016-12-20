class CommentsController < ApplicationController
  before_action :logged_in_user

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
  end

  def destroy
    @comment = Comment.find_by id: params[:id]
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
end
