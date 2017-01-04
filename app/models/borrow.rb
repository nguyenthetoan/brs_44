class Borrow < ApplicationRecord
  scope :expired, -> {where "due_date < ?", Time.zone.now}
  scope :user_borrowing, -> {where "start_date < ?", Time.zone.now}
  before_save :default_status

  belongs_to :user
  belongs_to :book

  enum status: [:awaiting, :borrowing, :ended]

  validates :start_date, presence: true
  validates :due_date, presence: true

  validate :validate_date, on: :create

  def manual_save book
    self.start_date = parse_datetime_params borrow_params, "start_date"
    self.due_date = parse_datetime_params borrow_params, "due_date"
    self.user = current_user
    self.book = book
  end

  private
  def validate_date
    errors.add(:start_date, I18n.t("cant_be_in_past")) if start_date <= Time.zone.now
    errors.add(:due_date, I18n.t("cant_be_in_past")) if due_date <= Time.zone.now
    errors.add(:due_date, I18n.t("cant_be_lower")) if due_date < start_date
  end

  def default_status
    self.status ||= :awaiting
  end

end
