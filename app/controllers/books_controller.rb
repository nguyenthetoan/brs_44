class BooksController<ApplicationController

  def index
    @books = Book.paginate page: params[:page]
  end

  def show
  end

end
