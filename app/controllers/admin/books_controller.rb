class Admin::BooksController < ApplicationController
  layout "admin"

  include BooksHelper

  before_action :logged_in_user, :admin_user
  before_action :load_book, only: [:update, :destroy, :show]
  before_action :load_categories, except: [:index]

  def index
    if params[:filter]
      @books = filter_by params[:filter]
    else params[:search]
      @books = search_by params[:search]
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
        render :new
      end
    end
  end

  def destroy
    unless @book.nil?
      @book.destroy
      respond_to do |format|
        format.html {render Book.all}
      end
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
      format.html {render Book.all}
    end
  end

  private
  def book_params
    params.require(:book).permit :title, :publish_date, :author, :pages, :category_id
  end

  def load_categories
    @categories = Category.all
  end
end
