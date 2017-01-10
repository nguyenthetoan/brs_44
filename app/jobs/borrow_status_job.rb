class BorrowStatusJob < ApplicationJob
  queue_as :default
  self.queue_adapter = :sidekiq

  def perform borrow
    process_status borrow
  end

  private
  def process_status borrow
    book = borrow.book
    borrows = book.borrows.order("start_date")
    current_borrowing = book.borrows.borrowing.first
    if current_borrowing.nil?
      if borrow.start_date <= Time.zone.now
        borrow.update_attributes status: :borrowing
        NotifyMailer.send_accepted_borrow(borrow).deliver_now
      end
    else
      if borrow.start_date < current_borrowing.due_date
        borrow.update_attributes status: :rejected
        NotifyMailer.send_rejected_borrow(borrow).deliver_now
      end
    end
  end

end
