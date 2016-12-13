class Admin::BooksController < ApplicationController
  layout "admin"
  before_action :logged_in_user, :admin_user
  before_action :load_book, only: [:update, :destroy, :show]
  def index
    @books = Book.all
    @categories = Category.all
  end

  def new
    @book = Book.new
    @categories = Category.all
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
    unless @book.nil?
      @book.update_attributes book_params
      respond_to do |format|
        format.html {render Book.all}
      end
    end
  end

  private
  def book_params
    params.require(:book).permit :title, :publish_date, :author, :pages, :category_id
  end

  def load_book
    @categories = Category.all
    @book = Book.find_by id: params[:id]
  end
end
