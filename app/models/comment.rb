class Comment < ApplicationRecord
  belongs_to :review
  belongs_to :user

  scope :latest, -> {order(created_at: :desc)}

  validates :content, presence: true
end
