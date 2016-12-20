class Activity < ApplicationRecord
  belongs_to :activatable, polymorphic: true
  belongs_to :user

  enum action_type: [:start_follow, :unfollowed, :add_book, :delete_book,
    :comment_review, :add_review, :delete_review]

  scope :latest, -> {order(created_at: :desc)}
  has_many :likes, as: :likable, dependent: :destroy
end
