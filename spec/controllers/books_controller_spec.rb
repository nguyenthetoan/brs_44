require "rails_helper"

RSpec.describe BooksController, type: :controller do
  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    user = User.new FactoryGirl.attributes_for :user
    user.save!
    sign_in user
  end

  describe "GET #show/:id" do
    it "responds successfully with an HTTP 200 status code" do
      book = Book.new FactoryGirl.attributes_for :book
      book.save!
      get :show, params: {id: book.id}
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
  end

  describe "GET #index" do
    it "responds successfully with an HTTP 200 status code" do
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "responds successfully with an HTTP 200 with filter params" do
      get :index, params: {filter: "most_rate"}
      controller.params[:filter].should eql "most_rate"
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "responds successfully with an HTTP 200 with category params" do
      get :index, params: {cate: 1}
      controller.params[:cate].should eql 1
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "responds successfully with an HTTP 200 with category params" do
      get :index, params: {search: "a"}
      controller.params[:search].should eql "a"
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
  end
end
