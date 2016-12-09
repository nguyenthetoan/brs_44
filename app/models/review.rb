class Review < ApplicationRecord
  belongs_to :user
  belongs_to :book
  has_many :comments
  has_many :activities, as: :activatable, dependent: :destroy
end
