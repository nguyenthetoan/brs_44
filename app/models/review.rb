class Review < ApplicationRecord
  belongs_to :user
  belongs_to :book

  scope :latest, -> {order(created_at: :desc)}

  has_many :comments, dependent: :destroy
  has_many :likes, as: :likable, dependent: :destroy
  has_many :activities, as: :activatable, dependent: :destroy

  validates :rate, numericality: {less_than_or_equal_to: 5}
  validates :content, presence: true, length: {maximum: 500}
  validates :user_id, uniqueness: {scope: :book_id,
    message: I18n.t("unique_reviewer")}
end
