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
    @books = Book.all
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

  def add_fields name, f, association
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for association, new_object, child_index: id do |builder|
      render association.to_s.singularize + "_fields", f: builder
    end
    link_to name, "#", class: "add_fields",
      data: {id: id, fields: fields.gsub("\n", "")}
  end

  def generate_conversation message
    user = message.user
    host = message.chatroom.host
    end_html = "<span class='username'>#{user.name}</span>: #{message.body}</div>"
    end_right_html = "#{message.body} :<span class='username'>#{user.name}</span></div>"

    user != host ? "<div class='message left'>" + end_html : "<div class='message right'>" + end_right_html
  end

end
