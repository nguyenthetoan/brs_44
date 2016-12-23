class BooksController<ApplicationController
  include BooksHelper

  before_action :load_book, only: :show

  def index
    @categories = Category.select("id, name").all
    @books = Book.select("id, title").paginate page: params[:page], per_page: Settings.books.page
    if params[:filter]
      @books = filter_by(params[:filter]).paginate page: params[:page], per_page: Settings.books.page
    elsif params[:cate]
      @books = filter_cate(params[:cate]).paginate page: params[:page], per_page: Settings.books.page
    elsif params[:search]
      @books = search_by(params[:search]).paginate page: params[:page], per_page: Settings.books.page
    end
  end

  def show
    @review = Review.new
    @reviews = @book.reviews
    @bookmark = Bookmark.new
    @user_bookmark = current_user.get_bookmark @book if logged_in?
  end

end
