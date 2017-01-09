class Borrow < ApplicationRecord
  scope :expired, -> {where "due_date < ?", Time.zone.now}
  scope :user_borrowing, -> {where "start_date < ?", Time.zone.now}

  before_save :default_status
  after_create_commit {BorrowStatusJob.perform_later(self)}

  belongs_to :user
  belongs_to :book

  enum status: [:awaiting, :borrowing, :ended, :rejected]

  validates :start_date, presence: true
  validates :due_date, presence: true

  validate :validate_date, on: :create

  def manual_save book, borrow_params
    self.start_date = parse_datetime_params borrow_params, "start_date"
    self.due_date = parse_datetime_params borrow_params, "due_date"
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

  def parse_datetime_params params, label
    year   = params[(label.to_s + "(1i)").to_sym].to_i
    month  = params[(label.to_s + "(2i)").to_sym].to_i
    mday   = params[(label.to_s + "(3i)").to_sym].to_i
    hour   = (params[(label.to_s + "(4i)").to_sym] || 0).to_i
    minute = (params[(label.to_s + "(5i)").to_sym] || 0).to_i
    second = (params[(label.to_s + "(6i)").to_sym] || 0).to_i
    DateTime.civil_from_format(:local, year, month, mday, hour, minute, second)
  end

end
