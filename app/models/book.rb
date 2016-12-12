class Book < ApplicationRecord
  belongs_to :category
  has_and_belongs_to_many :bookmarks
  has_many :reviews
  has_many :likes, as: :likable, dependent: :destroy
end
