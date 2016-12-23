class Admin::CategoriesController<ApplicationController
  layout "admin"
  before_action :logged_in_user, :admin_user

  def index
    @categories = Category.all
    @category = Category.new
  end

  def create
    @category = Category.create cate_params
    respond_to do |format|
      if @result = @category.save
        format.js
      else
        format.js {render status: "500"}
      end
    end
  end

  def destroy
    @category = Category.find_by id: params[:id]
    if @category.books.empty?
      @category.destroy
      respond_to do |format|
        format.js
      end
    else
      flash[:danger] = t "warning_delete_cate"
      redirect_to admin_categories_path
    end
  end

  private
  def cate_params
    params.require(:category).permit :name
  end
end
