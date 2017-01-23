require "rails_helper"

RSpec.describe UsersController, type: :controller do
  before(:each) do
    @user = FactoryGirl.create :user
  end

  describe "GET #show/:id" do
    it "responds successfully with an HTTP 200 status code" do
      get :show, params: {id: @user.id}
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
  end
end
