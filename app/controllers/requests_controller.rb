class RequestsController<ApplicationController
  before_action :authenticate_user!
  before_action :load_request, only: [:update, :show, :destroy]

  def index
    @requests = current_user.requests.latest.paginate page: params[:page]
  end

  def new
    @request = Request.new
    respond_to do |format|
      format.html {render partial: "request_form", locals: {request: @request}}
    end
  end

  def show
    respond_to do |format|
      format.html {render partial: "edit", locals: {request: @request}}
    end
  end

  def create
    @request = current_user.requests.build request_params
    @request.save
    respond_to do |format|
      format.html {render @request}
    end
  end

  def update
    unless @request.nil?
      @request.update_attributes request_params
      respond_to do |format|
        format.html {render Request.all.latest}
      end
    end
  end

  def destroy
    unless @request.nil?
      @request.destroy
      respond_to do |format|
        format.html {render Request.all.latest}
      end
    end
  end

  private
  def request_params
    params.require(:request).permit :title, :content, :status
  end

  def load_request
    @request = Request.find_by id: params[:id]
  end
end
