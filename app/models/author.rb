class Author < ApplicationRecord
  belongs_to :publisher, optional: true
  has_many :books, dependent: :destroy
  validates :name, presence: true, length: {maximum: 150}

end
