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
    when "user"
      return User
    end
  end

  def beloved_book
    books = Book.select("id, title, category_id, slug")
    @beloved = books.sort_by {|b| b.favorited_by.size}.flatten.reverse!.first(Settings.fav_items)
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

  def add_fields name, f, association
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for association, new_object, child_index: id do |builder|
      render association.to_s.singularize + "_fields", f: builder
    end
    link_to name, "#", class: "add_fields",
      data: {id: id, fields: fields.gsub("\n", "")}
  end
end
