class Admin::BooksController < ApplicationController
  before_action :authenticate_user!, :admin_user
  load_and_authorize_resource

  layout "admin"

  include BooksHelper

  before_action :load_book, only: [:destroy, :update]
  before_action :load_relationships, except: [:index]

  def index
    if params[:filter]
      @books = filter_by(params[:filter]).latest
    else params[:search]
      @books = search_by(params[:search]).latest
    end
  end

  def new
    @book = Book.new
    respond_to do |format|
      format.html {render partial: "book_form", locals: {book: @book}}
    end
  end

  def create
    @book = Book.create book_params
    respond_to do |format|
      if @book.save
        format.html {render @book}
      else
        render json: {errors: @book.errors.full_messages}
      end
    end
  end

  def destroy
    @book.destroy
    respond_to do |format|
      format.html
    end
  end

  def show
    respond_to do |format|
      format.html {render partial: "edit", locals: {book: @book}}
    end
  end

  def update
    @book.update_attributes book_params
    respond_to do |format|
      format.html {render @book.reload}
    end
  end

  private
  def book_params
    params.require(:book).permit :title, :publish_date, :pages, :category_id,
      :description, :author_id, :publisher_id,
      specifications_attributes: [:id, :specification_name, :specification_value, :_destroy]
  end

  def load_relationships
    @publishers = Publisher.select("id, name")
    @categories = Category.all
    @authors = Author.select("id, name")
  end

end
