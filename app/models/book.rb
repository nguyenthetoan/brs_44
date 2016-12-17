class Book < ApplicationRecord

  belongs_to :category
  has_many :favorites, dependent: :destroy
  has_many :favorited_by, through: :favorites, source: :user
  has_many :reviews, dependent: :destroy

  validates :title, presence: true
  validates :publish_date, presence: true
  validates :author, presence: true

  def avg_rating
    avg = self.reviews.average(:rate)
    avg.nil? ? avg = 0 : avg.truncate(2).to_s('F').to_f.round
  end
end
