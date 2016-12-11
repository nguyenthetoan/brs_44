class Admin::CategoriesController<ApplicationController
  layout "admin"
  before_action :logged_in_user, :admin_user

  def index
    @categories = Category.all
    @category = Category.new
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.create cate_params
    respond_to do |format|
      if @category.save
        format.js {flash[:success] = t "cate_created"}
      else
        render :new
      end
    end
  end

  def destroy
    @category = Category.find_by id: params[:id]
    @category.destroy
    respond_to do |format|
      format.js
    end
  end

  private
  def cate_params
    params.require(:category).permit :name
  end
end
