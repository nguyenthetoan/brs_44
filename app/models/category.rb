class Category < ApplicationRecord
  has_many :books, dependent: :destroy
  validates :name, presence: true, uniqueness: true, length: {maximum: 150}

  def update_category id
    current_max_right = max_right
    if id.empty?
      current_max_right.nil? ? self.update(lft: 1, rgt: 2, depth: 0)
        : self.update(lft: current_max_right + 1, rgt: current_max_right + 2, depth: 0)
    else
      parent = Category.find_by id: id
      Category.where("rgt >= ?", parent.rgt).update_all("rgt = rgt + 2")
      Category.where("lft >= ?", parent.rgt).update_all("lft = lft + 2")
      self.update(lft: parent.rgt, rgt: parent.rgt + 1, depth: parent.depth + 1)
    end
  end

  def leaf?
    rgt == lft + 1
  end

  def delete_category
    Category.where("rgt >= ?", self.rgt).update_all("rgt = rgt - 2")
    Category.where("lft >= ?", self.rgt).update_all("lft = lft - 2")
  end

  private
  def max_right
    Category.maximum(:rgt)
  end
end
