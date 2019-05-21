class Order < ActiveRecord::Base

  belongs_to :user
  has_many :line_items
  has_many :products, through: :line_items # has many through association

  monetize :total_cents, numericality: true

  validates :stripe_charge_id, presence: true

  after_create :update_inventory


  def update_inventory
    self.line_items.each do |item| 
      product = Product.find_by(id: item.product.id)
      original = product.quantity
      product.update(quantity: (original - item.quantity))
    end
  end

  
  # def line_items
  #   LineItem.where(order_id: id)
  # end

  # monetize :total_cents
  # def total
  #   total_cents / 100
  # end
end
