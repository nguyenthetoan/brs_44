module ApplicationHelper
  def full_title page_title = ""
    base_title = t "app_name"
    page_title.empty? ? base_title : page_title + " | " + base_title
  end

  def generate_activity object
    case object.class.name
    when "User"
      "<a href='/users/#{object.id}'>#{object.name}</a>"
    when "Book"
      "<a href='/books/#{object.id}'>#{object.title}</a>"
    when "Comment"
      "<a href='/books/#{object.review.book.id}##{dom_id(object.review)}'>#{I18n.t('on_review')}</a>"
    when "Bookmark"
      "<a href='/books/#{object.book.id}'>#{object.book.title} #{I18n.t('as')} <strong>#{object.read}</strong></a>"
    end
  end

  def load_importable object
    case object
    when "author"
      return Author
    when "publisher"
      return Publisher
    end
  end

  def beloved_book
    @books = Book.select("id, title, author, description")
    @beloved = @books.sort_by {|b| b.favorited_by.length}
    @beloved.reverse![0..4].sample
  end

  def _resource_name
    :user
  end

  def _resource
    @resource ||= User.new
  end

  def _devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def index_for counter, page, per_page
    (page - 1) * per_page + counter + 1
  end

end
