class ProcessBorrowWorker
  include Sidekiq::Worker
  # sidekiq_options retry: 5

  def perform
    expireds = Borrow.expired
    unless expireds.empty?
      expireds.update_all status: :ended
      expireds.each do |borrow|
        NotifyMailer.send_expired_borrow borrow
      end
    end

    awaitings = Borrow.awaiting
    awaitings.each do |borrow|
      if Time.zone.now >= borrow.start_date
        borrow.update_attributes status: :borrowing
        NotifyMailer.send_accepted_borrow borrow
      end
    end
  end
end
