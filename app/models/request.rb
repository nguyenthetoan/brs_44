class Request < ApplicationRecord
  belongs_to :user
  scope :latest, -> {order(created_at: :desc)}
  scope :pending, -> {where(status: 0)}
  scope :sent, -> {where(status: 1)}
  scope :accepted, -> {where(status: 2)}
  scope :denied, -> {where(status: 3)}
  scope :processed, -> {where(status: [:accepted, :denied])}

  enum status: [:pending, :sent, :accepted, :denied]

  validates :title, presence: true
  validates :content, presence: true
end
