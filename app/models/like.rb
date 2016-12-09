class Like < ApplicationRecord
  belongs_to :likable, polymorphic: true
  with_exclusive_scope -> {order(created_at: :desc)}
end
