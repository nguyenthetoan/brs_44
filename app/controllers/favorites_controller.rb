class FavoritesController<ApplicationController
  before_action :logged_in_user, only: [:update, :destroy]
  before_action :load_book
  def create
    current_user.add_favorite @book
    current_user.activities.create(activatable: @book, action_type: :add_book)
    respond_to do |format|
      format.html
    end
  end

  def destroy
    current_user.remove_favorite @book
    current_user.activities.create(activatable: @book, action_type: :delete_book)
    respond_to do |format|
      format.html
    end
  end

end
