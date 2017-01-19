require "rails_helper"

RSpec.describe Activity, type: :model do
  describe "Activity db schema" do
    context "column" do
      it {should have_db_column(:activatable_type).of_type(:string)}
      it {should have_db_column(:activatable_id).of_type(:integer)}
      it {should have_db_column(:user_id).of_type(:integer)}
      it {should define_enum_for(:action_type)}
    end
  end

  describe "book instance methods" do
    before(:each) do
      @user = User.first
    end
    subject {@user.activities.create(activatable: Book.first, action_type: :add_book)}
    it ".liked?" do
      subject.liked?(@yser).should be_truthy
    end
  end
end
