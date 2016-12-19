class Activity < ApplicationRecord
  belongs_to :activatable, polymorphic: true
  scope :latest, -> {order(created_at: :desc)}
  has_many :likes, as: :likable, dependent: :destroy
end
