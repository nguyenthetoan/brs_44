class Bookmark < ApplicationRecord
  belongs_to :book
  belongs_to :user

  has_many :activities, as: :activatable, dependent: :destroy

  enum read: [:read, :reading]
end
