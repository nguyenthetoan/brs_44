require "rails_helper"

RSpec.describe StaticPagesController, type: :controller do
  describe "all static pages" do
    it "render #home page" do
      get :show, page: "home"
      expect(response).to render_template :home
    end

    it "render #contact page" do
      get :show, page: "contact"
      expect(response).to render_template :contact
    end
  end
end
