module BooksHelper
  def filter_by val
    @books = Book.all
    @most_rate = @books.sort_by {|b| b.avg_rating}
    @most_favorites = @books.sort_by {|b| b.favorited_by.count}

    case val
    when ""
      @books
    when "most_rate"
      @books = @most_rate.reverse!
    when "most_favorites"
      @books = @most_favorites.reverse!
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
