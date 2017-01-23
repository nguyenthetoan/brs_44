class ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_review, only: [:destroy, :update, :show]

  def create
    @book = Book.find_by id: params[:book_id]
    @review = current_user.reviews.build review_params
    @review.book = @book
    if @review.save
      current_user.activities.create(activatable: @review.book, action_type: :add_review)
      redirect_back fallback_location: :back
    else
      flash[:danger] = t "blank_input"
      redirect_back fallback_location: :back
    end
  end

  def destroy
    unless @review.nil?
      @review.destroy
      current_user.activities.create(activatable: @review.book, action_type: :delete_review)
      redirect_back fallback_location: :back
    end
  end

  def update
    @book = Book.find_by id: params[:book_id]
    unless @review.nil?
      @review.update_attributes review_params
      redirect_back fallback_location: :back
    end
  end

  def show
    @book = Book.find_by id: params[:book_id]
    respond_to do |format|
      format.html {render partial: "edit", locals: {review: @review, book: @book}}
    end
  end

  private
  def review_params
    params.require(:review).permit :rate, :content
  end

  def load_review
    @review = Review.find_by id: params[:id]
  end
end
