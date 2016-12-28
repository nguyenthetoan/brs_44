class Admin::BooksController < ApplicationController
  layout "admin"

  include BooksHelper

  before_action :load_book, only: [:destroy, :update]
  before_action :authenticate_user!, :admin_user
  before_action :load_categories, except: [:index]

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
    params.require(:book).permit :title, :publish_date, :author, :pages, :category_id, :description
  end

  def load_categories
    @categories = Category.select("id, name, created_at")
  end

end
