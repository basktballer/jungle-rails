class Product < ActiveRecord::Base

  monetize :price_cents, numericality: true
  mount_uploader :image, ProductImageUploader

  belongs_to :category
  has_many :reviews

  validates :name, presence: true
  validates :price, presence: true
  validates :quantity, presence: true
  validates :category, presence: true

  def sold_out?
    self.quantity == 0 ? true : false
  end

  def avg_rating
    arr = Array.new
    self.reviews.each do |review|
      arr.push(review.rating)
    end
    arr.length == 0 ? 0 : (arr.sum / arr.length)
  end

end
