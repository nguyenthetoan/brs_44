class Supports::Book
  attr_reader :book

  def initialize book
    @book = book
  end

  def borrowed
    @book.borrows.where(status: :borrowing).first
  end

  def queues
    @book.borrows.where(status: :awaiting).order("start_date").limit(3)
  end

  def user_bookmark current_user
    current_user.get_bookmark @book
  end

  def reviews
    @book.reviews
  end

end
