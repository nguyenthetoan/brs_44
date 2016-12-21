class Comment < ApplicationRecord
  belongs_to :review
  belongs_to :user

  has_many :likes, as: :likable, dependent: :destroy
  has_many :activities, as: :activatable, dependent: :destroy

  scope :latest, -> {order(created_at: :desc)}

  validates :content, presence: true
end
