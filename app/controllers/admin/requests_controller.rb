class Admin::RequestsController<ApplicationController
  layout "admin"
  before_action :logged_in_user, :admin_user
  before_action :load_request, only: [:update, :show]

  def index
    @received_requests = Request.sent.latest.paginate page: params[:page]
    @processed_requests = Request.processed.paginate page: params[:page]
  end

  def show
    respond_to do |format|
      format.html {render partial: "edit", locals: {request: @request}}
    end
  end

  def update
    @request.update_attributes request_params
    @processed_requests = Request.processed.paginate page: params[:page]
    respond_to do |format|
      format.html {render @processed_requests}
    end
  end

  private
  def load_request
    @request = Request.find_by id: params[:id]
  end

  def request_params
    params.require(:request).permit :status
  end
end
