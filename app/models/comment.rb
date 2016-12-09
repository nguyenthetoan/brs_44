class Comment < ApplicationRecord
  belongs_to :review
  belongs_to :user
  has_many :activities, as: :activatable, dependent: :destroy
end
