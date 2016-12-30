class Publisher < ApplicationRecord
  has_many :authors, dependent: :destroy
  validates :name, presence: true, length: {maximum: 200}

  scope :total_book, -> {joins(:authors, :books).select("authors.books.title")}

  def total_books
    authors.collect(&:books).flatten
  end

  def total_categories
    authors.collect(&:books).flatten.uniq.collect(&:category)
  end

end
