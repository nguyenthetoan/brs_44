class FavoritesController<ApplicationController
  before_action :logged_in_user, only: [:update, :destroy]
  before_action :load_book

  def create
    current_user.add_favorite @book
    respond_to do |format|
      format.html
    end
  end

  def destroy
    current_user.remove_favorite @book
    respond_to do |format|
      format.html
    end
  end

  private
  def load_book
    @book = Book.find_by id: params[:id]
  end
end
