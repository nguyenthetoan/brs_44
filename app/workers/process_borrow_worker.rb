class ProcessBorrowWorker
  include Sidekiq::Worker
  # sidekiq_options retry: 5

  def perform
    borrowings = Borrow.borrowing
    working_borrowings borrowings

    awaitings = Borrow.awaiting
    working_awaitings awaitings
  end

  private
  def working_borrowings borrowings
    unless borrowings.empty?
      borrowings.each do |borrow|
        borrow.update_attributes status: :ended if borrow.due_date <= Time.zone.now
      end
      Borrow.ended.each do |borrow|
        NotifyMailer.send_expired_borrow(borrow).deliver_now
        borrow.update_attributes status: :sent_expiration
      end
    end
  end

  def working_awaitings awaitings
    awaitings.each do |borrow|
      if Time.zone.now >= borrow.start_date
        borrow.update_attributes status: :borrowing
        NotifyMailer.send_accepted_borrow(borrow).deliver_now
      end
    end
  end

end
