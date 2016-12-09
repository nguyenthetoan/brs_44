class Bookmark < ApplicationRecord
  has_and_belongs_to :books
  belongs_to :user
  has_many :activities, as: :activatable, dependent: :destroy
end
