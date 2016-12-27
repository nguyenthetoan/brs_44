class BookmarksController<ApplicationController
  before_action :authenticate_user!, only: [:create, :update]
  before_action :load_book, only: :update
  def create
    @bookmark = current_user.bookmarks.build bookmark_params
    @bookmark.save
    current_user.activities.create(activatable: @bookmark, action_type: :new_bookmark)
    redirect_back(fallback_location: :back)
  end

  def update
    unless current_user.nil?
      @bookmark = current_user.get_bookmark @book
      @bookmark.update_attributes bookmark_params
      current_user.activities.create(activatable: @bookmark, action_type: :update_bookmark)
      redirect_back(fallback_location: :back)
    end
  end

  private
  def bookmark_params
    params.require(:bookmark).permit :read, :book_id
  end
end
