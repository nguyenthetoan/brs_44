class BorrowStatusJob < ApplicationJob
  queue_as :default

  def perform borrow
    book = borrow.book
    borrows = book.borrows.order("start_date")
    if book.available_borrow? && (borrow.start_date == Time.zone.now)
      borrow.update_attributes status: :borrowing
    else
      current_borrowing = book.borrows.borrowing.first
      if borrow.start_date < current_borrowing.due_date
        NotifyMailer.send_rejected_borrow(borrow).deliver_now
        borrow.update_attributes status: :rejected
      end
    end
  end
end
