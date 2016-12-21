class Activity < ApplicationRecord
  belongs_to :activatable, polymorphic: true
  belongs_to :user
  belongs_to :book
  belongs_to :review
  belongs_to :comment
  belongs_to :bookmark
  enum action_type: [:start_follow, :unfollowed, :add_book, :delete_book,
    :comment_review, :add_review, :delete_review, :new_bookmark, :update_bookmark]

  scope :latest, -> {order(created_at: :desc)}

  has_many :likes, as: :likable, dependent: :destroy

  def liked? user
    likes.exists? user_id: user.id
  end
end
