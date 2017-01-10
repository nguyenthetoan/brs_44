class Admin::AuthorsController < ApplicationController
  load_and_authorize_resource
  layout "admin"
  before_action :authenticate_user!

  def index
    @authors = Author.select("id, name, bio").paginate page: params[:page], per_page: Settings.item_per_page
    @author = Author.new
    respond_to do |format|
      format.html
      format.xlsx
    end
  end

  def update
    respond_to do |format|
      if @author.update_attributes author_params
        format.html {render @author.reload}
      else
        format.html
      end
    end
  end

  def show
    @author_books = @author.books
    cates = @author.books.select("category_id")
    @author_categories = Category.where id: cates
  end

  def edit
    respond_to do |format|
      format.html {render partial: "edit", locals: {author: @author}}
    end
  end

  def create
    @author = Author.new author_params
    respond_to do |format|
      if @author.save
        format.html {render @author}
      else
        format.html
      end
    end
  end

  def destroy
    respond_to do |format|
      if @author.books.any?
        format.js {render status: 500}
      elsif @author.destroy
        format.html
      end
    end
  end

  private

  def author_params
    params.require(:author).permit :name, :bio, :publisher_id
  end

end
