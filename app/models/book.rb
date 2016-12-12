class Book < ApplicationRecord

  belongs_to :category

  validates :title, presence: true, uniqueness: true
  validates :publish_date, presence: true
  validates :author, presence: true
end
