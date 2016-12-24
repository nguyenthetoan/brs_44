module BooksHelper

  def load_books
    @books = Book.select("id, title")
  end

  def filter_by val
    case val
    when ""
      load_books
    when "most_rate"
      @most_rate = load_books.sort_by {|b| b.avg_rating}
      @books = @most_rate.reverse!
    when "most_favorites"
      @most_favorites = load_books.sort_by {|b| b.favorited_by.size}
      @books = @most_favorites
    end
  end

  def search_by val
    val ||= ""
    @books = Book.search(val).paginate page: params[:page]
  end

  def filter_cate id
    id ||= ""
    @cate = Category.find_by id: id
    @books = @cate.books.paginate page: params[:page]
  end
end
