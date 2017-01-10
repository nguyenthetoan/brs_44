require "rails_helper"

RSpec.describe Publisher, type: :model do
  describe "Publisher db schema" do
    context "column" do
      it {should have_db_column(:name).of_type(:string)}
      it {should have_db_column(:description).of_type(:string)}
    end
  end

  describe "validating" do
    subject {FactoryGirl.create :publisher}
    context "association" do
      it {is_expected.to have_many :authors}
    end

    context "validates" do
      it {expect validate_presence_of :name}
    end
  end

  describe "publisher instance methods" do
    before {FactoryGirl.create :publisher}
    subject {Publisher.first}
    it "counts total book" do
      expect(subject.total_books).to be_a(Array)
    end

    it "counts categories of publisher" do
      expect(subject.total_categories).to be_a(Array)
    end
  end
end
