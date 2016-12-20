class BooksController<ApplicationController
  include BooksHelper

  before_action :load_book, only: :show

  def index
    if params[:filter]
      @books = filter_by params[:filter]
    else params[:search]
      @books = search_by params[:search]
    end
  end

  def show
    @review = Review.new
    @reviews = @book.reviews.latest
  end

end
