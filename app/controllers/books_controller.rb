class BooksController<ApplicationController

  def index
    @books = Book.paginate page: params[:page]
  end

  def show
    @book = Book.find_by id: params[:id]
  end

end
