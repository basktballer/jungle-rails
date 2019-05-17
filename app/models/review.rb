class Review < ActiveRecord::Base
  validates :product_id, presence: true
  validates :user_id, presence: true
  validates :description, presence: true
  validates :rating, 
    numericality: {
      only_integer: true,
      greater_than_or_equal_to: 1,
      less_than_or_equal_to: 5
    }

  belongs_to :product

end