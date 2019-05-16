class LineItem < ActiveRecord::Base

  belongs_to :order
  belongs_to :product

  monetize :item_price_cents, numericality: true
  monetize :total_price_cents, numericality: true

  # belongs_to :order
  def order
    Order.find(order_id)
  end
end
