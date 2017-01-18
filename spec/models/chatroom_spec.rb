require 'rails_helper'

RSpec.describe Chatroom, type: :model do
  describe "chatroom scope" do
    it "scope created room" do
      host = FactoryGirl.create :user
      guest = FactoryGirl.create :user
      created_room = Chatroom.created_room host, guest
      expect(created_room).not_to exist
    end
  end
end
