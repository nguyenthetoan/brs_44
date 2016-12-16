class Request < ApplicationRecord
  belongs_to :user
  scope :latest, -> {order(created_at: :desc)}
  scope :pending, -> {where(status: 0)}
  scope :sent, -> {where(status: 1)}
  scope :cancel, -> {where(status: 2)}
  scope :accepted, -> {where(status: 3)}
  scope :denied, -> {where(status: 4)}

  enum status: [:pending, :sent, :cancel, :accepted, :denied]

  validates :title, presence: true
  validates :content, presence: true
end
