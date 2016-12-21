class Book < ApplicationRecord

  scope :search, -> (condition) {where("author LIKE :search OR title LIKE :search",
    search: "%#{condition}%")}

  belongs_to :category
  has_many :favorites, dependent: :destroy
  has_many :favorited_by, through: :favorites, source: :user
  has_many :reviews, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :bookmarked_by, through: :bookmarks, source: :user, dependent: :destroy

  has_many :activities, as: :activatable, dependent: :destroy

  validates :title, presence: true
  validates :publish_date, presence: true
  validates :author, presence: true

  def avg_rating
    avg = self.reviews.average(:rate)
    avg.nil? ? avg = 0 : avg.truncate(2).to_s('F').to_f.round
  end

  def bookmarked? user
    bookmarks.exists? user_id: user.id
  end

end
