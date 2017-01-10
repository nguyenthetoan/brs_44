require "rails_helper"

RSpec.describe Book, type: :model do
  describe "db schema" do
    context "columns" do
      it {should have_db_column(:title).of_type(:string)}
      it {should have_db_column(:pages).of_type(:integer)}
      it {should have_db_column(:publish_date).of_type(:date)}
      it {should have_db_column(:description).of_type(:text)}
      it {should have_db_column(:category_id).of_type(:integer)}
      it {should have_db_column(:author_id).of_type(:integer)}
      it {should have_db_column(:publisher_id).of_type(:integer)}
    end
  end

  describe "test model" do
    subject {FactoryGirl.create :book}
    it {is_expected.to be_valid}

    context "associations" do
      it {is_expected.to belong_to :author}
      it {is_expected.to belong_to :category}
      it {is_expected.to belong_to :publisher}
      it {is_expected.to have_many :specifications}
      it {is_expected.to have_many :favorites}
      it {is_expected.to have_many :favorited_by}
      it {is_expected.to have_many :reviews}
      it {is_expected.to have_many :bookmarks}
      it {is_expected.to have_many :bookmarked_by}
      it {is_expected.to have_many :borrows}
      it {is_expected.to have_many :borrowed_by}
    end

    context "validations" do
      it {should validate_presence_of(:title)}
      it {should validate_presence_of(:pages)}
      it {should validate_numericality_of(:pages).only_integer}
      it {should validate_presence_of(:publish_date)}
    end
  end

  describe "nested attributes" do
    subject {FactoryGirl.create :book}
    it "accepts nested attributes" do
      book_params = FactoryGirl.attributes_for(:book)
      specifications_attributes = [{specification_name: "lul", specification_value: "lmao"}]
      book_params[:specifications_attributes] = specifications_attributes
      book = Book.create book_params
      expect(book.specifications).to be_present
    end
  end

  describe "book instance methods" do
    before {FactoryGirl.create :book}
    subject {Book.first}
    it ".avg_rating" do
      subject.avg_rating.should be_a(Integer)
    end

    it ".available_borrow?" do
      expect(subject.available_borrow?).to be_truthy
    end
  end
end
