class Review < ApplicationRecord
  belongs_to :user
  belongs_to :book

  scope :latest, -> {order(created_at: :desc)}

  has_many :comments, dependent: :destroy

  validates :rate, numericality: {less_than_or_equal_to: 5}
  validates :content, presence: true, length: {maximum: 500}
  validates :user_id, uniqueness: {scope: :book_id}
end
