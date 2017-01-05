class Chatroom < ApplicationRecord
  scope :created_room, -> (host, guest) {
    where("host_id = ? AND guest_id = ?", "#{host.id}", "#{guest.id}")
  }

  belongs_to :host, class_name: User.name
  belongs_to :guest, class_name: User.name

  has_many :messages, dependent: :destroy

end
