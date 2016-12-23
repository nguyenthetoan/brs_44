class User < ApplicationRecord

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  has_many :active_relationships,  class_name: Relationship.name,
    foreign_key: :follower_id, dependent: :destroy
  has_many :passive_relationships, class_name: Relationship.name,
    foreign_key: :followed_id, dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  has_many :favorites, dependent: :destroy
  has_many :requests, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :activities, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :bookmarks, dependent: :destroy

  before_save {self.email = email.downcase}
  validates :name, presence: true, length: {maximum: 50}
  validates :email, presence: true,
    length: {maximum: 255},
    format: {with: VALID_EMAIL_REGEX},
    uniqueness: {case_sensitive: false}, allow_nil: true
  validates :password, length: {minimum: 6}, allow_nil: true
  has_secure_password

  def is_user? current_user
    self == current_user
  end

  def add_favorite book
    favorites.create book_id: book.id
  end

  def remove_favorite book
    if favorited? book
      favorites.find_by(book_id: book.id).destroy
    end
  end

  def favorited? book
    favorites.find_by(book_id: book.id).present?
  end

  def follow other_user
    active_relationships.create followed_id: other_user.id
  end

  def unfollow other_user
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  def following? other_user
    following.include? other_user
  end

  def get_bookmark book
    bookmark = Bookmark.find_by user_id: self.id, book_id: book.id
  end

  def bookmarkeds
    bookmarks = Bookmark.where user_id: self.id
  end

  def reviewed? book
    book.reviewed_by.reload.include? self
  end

end
