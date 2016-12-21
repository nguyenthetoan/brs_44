class BooksController<ApplicationController
  include BooksHelper

  before_action :load_book, only: :show

  def index
    @categories = Category.select("id, name").all
    @books = Book.all
    if params[:filter]
      @books = filter_by params[:filter]
    elsif params[:cate]
      @books = filter_cate params[:cate]
    elsif params[:search]
      @books = search_by params[:search]
    end
  end

  def show
    @review = Review.new
    @reviews = @book.reviews.latest
    @bookmark = Bookmark.new
    @user_bookmark = current_user.get_bookmark @book
  end

end
