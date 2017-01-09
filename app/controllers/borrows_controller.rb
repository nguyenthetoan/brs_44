class BorrowsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def new
    @borrow = Borrow.new
    respond_to do |format|
      format.html{render partial: "borrow_form", locals: {borrow: @borrow}}
    end
  end

  def create
    book = Book.friendly.find params[:id]
    @borrow = current_user.borrows.build
    @borrow.manual_save book, borrow_params
    if @borrow.save
      flash[:notice] = t "done_borrowing"
      redirect_back fallback_location: :back
    else
      flash[:alert] = t "failed_borrowing"
      redirect_back fallback_location: :back
    end
  end

  private
  def borrow_params
    params.require(:borrow).permit :start_date, :due_date
  end
end
