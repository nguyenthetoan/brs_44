class Admin::BooksController < ApplicationController
  layout "admin"
  before_action :logged_in_user, :admin_user

  def index
    @books = Book.all
    @book = Book.new
    @categories = Category.all
  end

  def create
    @book = Book.new book_params
    respond_to do |format|
      if @book.update_attributes category_id: params[:category_id]
        format.js
      else
        render :new
      end
    end
  end

  def destroy
    @book = Book.find_by id: params[:id]
    unless @book.nil?
      @book.destroy
      respond_to do |format|
        format.js
      end
    end
  end

  private
  def book_params
    params.require(:book).permit :title, :publish_date, :author, :pages, :category_id
  end

end
