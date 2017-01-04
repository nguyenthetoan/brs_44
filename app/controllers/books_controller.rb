class BooksController<ApplicationController
  include BooksHelper

  before_action :load_book, only: :show

  def index
    @categories = Category.select("id, name")
    @books = Book.select("id, title, slug").paginate page: params[:page], per_page: Settings.books.page
    if params[:filter]
      @books = filter_by(params[:filter]).paginate page: params[:page], per_page: Settings.books.page
    elsif params[:cate]
      @books = filter_cate(params[:cate]).paginate page: params[:page], per_page: Settings.books.page
    elsif params[:search]
      @books = search_by(params[:search]).paginate page: params[:page], per_page: Settings.books.page
    end
  end

  def show
    @supports = Supports::Book.new @book
    if signed_in?
      @review = Review.new
      @bookmark = Bookmark.new
    end
  end

end
