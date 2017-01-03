class Specification < ApplicationRecord
  belongs_to :book

  validates :specification_name, presence: true, length: {maximum: 100}
  validates :specification_value, presence: true, length: {maximum: 100}
end
