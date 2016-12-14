class Book < ApplicationRecord

  belongs_to :category
  has_many :favorites, dependent: :destroy
  has_many :favorited_by, through: :favorites, source: :user

  validates :title, presence: true
  validates :publish_date, presence: true
  validates :author, presence: true
end
