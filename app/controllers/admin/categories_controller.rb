class Admin::CategoriesController<ApplicationController
  before_action :authenticate_user!, :admin_user
  load_and_authorize_resource except: [:create]

  layout "admin"

  def index
    @category = Category.new
    @categories = Category.order("lft")
  end

  def update
    respond_to do |format|
      if @category.update_attributes cate_params
        format.html {render @category.reload}
      else
        format.html
      end
    end
  end

  def show
    respond_to do |format|
      format.html {render partial: "edit", locals: {category: @category}}
    end
  end

  def create
    @category = Category.new cate_params
    respond_to do |format|
      if @category.update_category params[:parent_id]
        format.html {render @category}
      else
        format.html
      end
    end
  end

  def destroy
    respond_to do |format|
      if !@category.leaf? || @category.books.any?
        format.js {render status: 500}
      elsif @category.delete_category && @category.destroy
        format.html
      end
    end
  end

  private

  def cate_params
    params.require(:category).permit :name
  end

end
