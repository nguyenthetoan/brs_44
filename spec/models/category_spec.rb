require "rails_helper"

RSpec.describe Category, type: :model do
  describe "Category db schema" do
    context "column" do
      it {should have_db_column(:name).of_type(:string)}
      it {should have_db_column(:depth).of_type(:integer)}
      it {should have_db_column(:lft).of_type(:integer)}
      it {should have_db_column(:rgt).of_type(:integer)}
    end
  end

  describe "validations" do
    context "association" do
      it {is_expected.to have_many :books}
    end

    context "validates" do
      it {expect validate_presence_of :name}
      it {expect validate_uniqueness_of(:name)}
    end
  end

  describe "Category" do
    subject {Category.first}
    it ".leaf?" do
      expect(subject.leaf?).to be false
    end
    it ".delete_category" do
      expect(subject.delete_category).to be_an Integer
    end

    it ".update_category" do
      expect(subject.update_category("7")).to be true
    end
    it "update greate grand category" do
      expect(subject.update_category("")).to be_a Category
    end
  end

end
