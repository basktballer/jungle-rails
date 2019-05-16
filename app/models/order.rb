class Order < ActiveRecord::Base

  belongs_to :user
  has_many :line_items
  has_many :products, through: :line_items # has many through association

  monetize :total_cents, numericality: true

  validates :stripe_charge_id, presence: true
  
  # def line_items
  #   LineItem.where(order_id: id)
  # end

  # monetize :total_cents
  # def total
  #   total_cents / 100
  # end
end
