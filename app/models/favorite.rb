class Favorite < ApplicationRecord
  belongs_to :book
  belongs_to :user
  scope :latest, -> {order(created_at: :desc)}
end
