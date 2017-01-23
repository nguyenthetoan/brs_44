require "rails_helper"

RSpec.describe ReviewsController, type: :controller do
  before(:each) do
    user = FactoryGirl.create :user
    sign_in(:user, user)
    @book = Book.first
    @reviews = @book.reviews
  end

  describe "POST #create" do
    it "condition to run" do
      post :create, params: {book_id: @book.id,
        review: {rate: 3, content: "example content"}}
    end

    it "create review successfully" do
      expect(post :create, params: {book_id: @book.id,
        review: {rate: 3, content: "example content"},
        format: :html}).to change(Review, :count).by(1)
      expect(response.content_type).to eq("text/html")
    end

    it "create review failed" do
      expect(post :create, params: {book_id: @book.id,
        review: {rate: "", content: ""}, format: :html}).to be false
      expect(response.content_type).to eq("text/html")
    end
  end

  describe "GET #show/:id" do
    it "responds successfully with an HTTP 200 status code" do
      get :show, params: {id: @reviews.first.id}
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
  end

  describe "PUT #update" do
    it "update review successful" do
      put :update, params: {book_id: @book.id, id: @reviews.first.id,
        review: {rate: 2, content: "Edit content"}}
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
  end

  describe "DELETE #destroy" do
    subject {@book.reviews.first}
    it "delete successful when there is a review" do
      expect(delete :destroy, params: {id: subject.id}).to change(Review, :count).by(0)
      expect(response).to redirect_to back
    end
  end
end
