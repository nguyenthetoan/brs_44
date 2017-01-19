require "rails_helper"

RSpec.describe User, type: :model do
  describe "User db schema" do
    context "column" do
      it {should have_db_column(:name).of_type(:string)}
      it {should have_db_column(:email).of_type(:string)}
      it {should have_db_column(:encrypted_password).of_type(:string)}
      it {should have_db_column(:role).of_type(:integer)}
      it {should have_db_column(:confirmed_at).of_type(:datetime)}
      it {should have_db_column(:slug).of_type(:string)}
      it {should have_db_column(:provider).of_type(:string)}
      it {should have_db_column(:uid).of_type(:string)}
    end
  end

  describe "validating" do
    subject {FactoryGirl.create :user}
    context "associations" do
      it {is_expected.to have_many :active_relationships}
      it {is_expected.to have_many :passive_relationships}
      it {is_expected.to have_many :following}
      it {is_expected.to have_many :followers}
      it {is_expected.to have_many :favorites}
      it {is_expected.to have_many :requests}
      it {is_expected.to have_many :reviews}
      it {is_expected.to have_many :comments}
      it {is_expected.to have_many :activities}
      it {is_expected.to have_many :likes}
      it {is_expected.to have_many :bookmarks}
      it {is_expected.to have_many :borrows}
      it {is_expected.to have_many :active_conversations}
      it {is_expected.to have_many :passive_conversations}
      it {is_expected.to have_many :messages}
      it {is_expected.to have_many :notifications}
    end

    context "validates" do
      it {expect validate_presence_of :name}
      it {expect validate_presence_of :email}
      it {expect validate_length_of :encrypted_password}
    end
  end

  auth_hash = OmniAuth::AuthHash.new(
    {
      provider: "facebook",
      uid: "1219",
      info: {
        email: "sings@domain.com",
        name: "Beaver Knight"
      }
  })

  describe ".from_omniauth" do
    it "retrieves an existing user" do
      user = User.new(
        provider: "facebook",
        uid: 1219,
        email: "sings@domain.com",
        password: "password",
        password_confirmation: "password"
      )
      user.save
      omniauth_user = User.from_omniauth(auth_hash)
      expect(user).to eq(omniauth_user)
    end

    it "creates a new user if one doesn't already exist" do
      expect{User.from_omniauth(auth_hash)}.to change(User, :count).by 1
    end
  end

  describe "user using books" do
    before(:each) do
      @book = Book.first
    end
    subject {User.first}
    it ".add_favorite" do
      subject.add_favorite(@book).should be_a(Favorite)
    end

    it ".remove_favorite" do
      expect(subject.remove_favorite(@book)).to be_truthy
    end

    it ".favorited?" do
      expect(subject.favorited?(@book)).to be false
    end

    it ".get_bookmark" do
      expect(subject.get_bookmark(@book)).not_to exist
    end
    it "bookmarkeds" do
      expect(subject.bookmarkeds).to be_empty
    end
  end

  describe "user relationships" do
    before(:each) do
      @other = User.last
    end
    subject {User.first}
    it ".follow" do
      subject.follow(@other).should be_a(Relationship)
    end

    it ".unfollow" do
      expect(subject.unfollow(@other)).to be_truthy
    end

    it ".following?" do
      expect(subject.following?(@other)).to be false
    end
  end
end
