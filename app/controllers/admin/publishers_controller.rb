class Admin::PublishersController < ApplicationController
  load_and_authorize_resource

  before_action :authenticate_user!

  layout "admin"

  def index
    respond_to do |format|
      format.html
      format.xlsx
    end
  end

  def new
    @publisher = Publisher.new
    respond_to do |format|
      format.html {render partial: "publisher_form", locals: {publisher: @publisher}}
    end
  end

  def show
    @publisher_authors = @publisher.authors.paginate page: params[:page]
    @publisher_books = @publisher.total_books.paginate page: params[:page]
    @publisher_categories = @publisher.total_categories.paginate page: params[:page]
  end

  def create
    @publisher = Publisher.new publisher_params
    respond_to do |format|
      if @publisher.save
        format.html {render @publisher}
      else
        format.html
      end
    end
  end

  def edit
    respond_to do |format|
      format.html {render partial: "edit", locals: {publisher: @publisher}}
    end
  end

  def update
    respond_to do |format|
      if @publisher.update_attributes publisher_params
        format.html {render @publisher.reload}
      else
        format.html
      end
    end
  end

  def destroy
    respond_to do |format|
      if @publisher.authors.any?
        format.js {render status: 500}
      elsif @publisher.destroy
        format.html
      end
    end
  end

  private
  def publisher_params
    params.require(:publisher).permit :name, :description
  end

end
