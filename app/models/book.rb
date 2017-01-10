class Book < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  scope :search, -> (condition) {where("title LIKE :search", search: "%#{condition}%")}
  scope :latest, -> {order(created_at: :desc)}

  belongs_to :category
  belongs_to :author
  belongs_to :publisher

  has_many :favorites, dependent: :destroy
  has_many :favorited_by, through: :favorites, source: :user
  has_many :reviews, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :bookmarked_by, through: :bookmarks, source: :user, dependent: :destroy
  has_many :reviewed_by, through: :reviews, source: :user, dependent: :destroy
  has_many :specifications, dependent: :destroy
  has_many :borrows, dependent: :destroy
  has_many :borrowed_by, through: :borrows, source: :user, dependent: :destroy

  validates :title, presence: true, length: {maximum: 150}, allow_nil: false
  validates :publish_date, presence: true

  validate :specifications, if: :exceed_specification?
  validates :pages, presence: true, numericality: {only_integer: true}
  accepts_nested_attributes_for :specifications, reject_if: :all_blank, allow_destroy: true

  def avg_rating
    avg = self.reviews.average(:rate)
    avg.nil? ? avg = 0 : avg.truncate(2).to_s('F').to_f.round
  end

  def available_borrow?
    !self.borrows.collect(&:borrowing?).any?
  end

  private
  def exceed_specification?
    (1..5) === self.specifications.size
  end

end
