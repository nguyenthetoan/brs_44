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
    end
  end

end
