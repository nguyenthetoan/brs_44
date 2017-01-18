require "rails_helper"

RSpec.describe Author, type: :model do
  describe "Author db schema" do
    context "column" do
      it {should have_db_column(:name).of_type(:string)}
      it {should have_db_column(:bio).of_type(:text)}
    end
  end

  describe "validating" do
    subject {FactoryGirl.create :author}
    context "association" do
      it {is_expected.to have_many :books}
      it {is_expected.to belong_to :publisher}
    end

    context "validates" do
      it {expect validate_presence_of :name}
    end
  end
end
