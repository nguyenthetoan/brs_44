class BooksController<ApplicationController
  before_action :load_book, only: :show

  def index
    params[:search] ||= ""
    @books = Book.search(params[:search])
      .select("id, title, author, publish_date, description")
      .paginate page: params[:page]
  end

  def show
    @review = Review.new
    @reviews = @book.reviews.latest
  end

end
