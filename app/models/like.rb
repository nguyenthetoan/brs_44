class Like < ApplicationRecord
  belongs_to :likable, polymorphic: true
  belongs_to :user
  belongs_to :activity
  belongs_to :review
  belongs_to :comment

  scope :latest, -> {order(created_at: :desc)}

  validates :user_id, uniqueness: {scope: [:likable_id, :likable_type]}
end
