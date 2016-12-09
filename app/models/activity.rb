class Activity < ApplicationRecord
  belongs_to :activatable, polymorphic: true
  with_exclusive_scope -> {order(created_at: :desc)}
  has_many :likes, as: :likable, dependent: :destroy
end
