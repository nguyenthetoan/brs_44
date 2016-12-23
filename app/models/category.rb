class Category < ApplicationRecord
  has_many :books, dependent: :destroy
  validates :name, presence: true, uniqueness: true, length: {maximum: 150}
end
