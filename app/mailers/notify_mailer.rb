class NotifyMailer < ApplicationMailer

  def send_available_borrow
    awaitings = Borrow.awaiting
    awaitings.each do |borrow|
      if (borrow.start_date - Time.zone.now).to_i / 1.day <= 2
        @borrow = borrow
        @user = borrow.user
        mail to: @user.email, subject: I18n.t("notify_borrow_status")
      end
    end
  end

  def send_expired_borrow borrow
    @borrow = borrow
    @user = borrow.user
    mail to: @user.email,
      subject: I18n.t("notify_expired_borrow", book: borrow.book.title)
  end

  def send_accepted_borrow borrow
    @borrow = borrow
    @user = borrow.user
    mail to: @user.email,
      subject: I18n.t("now_borrowing", book: borrow.book.title)
  end

  def send_rejected_borrow borrow
    @borrow = borrow
    mail to: borrow.user.email,
      subject: I18n.t("rejected_borrow", book: borrow.book.title)
  end

end
