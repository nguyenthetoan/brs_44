class Relationship < ApplicationRecord
  belongs_to :follower, class_name: User.name
  belongs_to :followed, class_name: User.name
  has_many :activities, as: :activatable, dependent: :destroy
end
