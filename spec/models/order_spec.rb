require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'After creation' do
    before :each do
      cat1 = Category.find_or_create_by! name: 'Apparel'
      # Setup at least two products with different quantities, names, etc
      @product1 = cat1.products.create!(
        name:  'Not Another Men\'s Classy shirt',
        description: Faker::Hipster.paragraph(4),
        image: 'apparel1.jpg',
        quantity: 19,
        price: 99.99      
      )
      @product2 = cat1.products.create!(
        name:  'Even more Hipster Hipster Socks',
        description: Faker::Hipster.paragraph(4),
        image: 'apparel4.jpg',
        quantity: 28,
        price: 55.55
      )
      # Setup at least one product that will NOT be in the order
      @product3 = cat1.products.create!(
        name:  'Old School Skateboards',
        description: Faker::Hipster.paragraph(4),
        image: 'electronics1.jpg',
        quantity: 40,
        price: 164.49
      )
    end
    # pending test 1
    it 'deducts quantity from products based on their line item quantities' do
      # TODO: Implement based on hints below
      # 1. initialize order with necessary fields (see orders_controllers, schema and model definition for what is required)
      @order = Order.new(
        email: 'kvirani@gmail.com',
        total_cents: 769.06,
        stripe_charge_id: 'ch_1EcLT32eZvKYlo2CGdFlVBQ9', # returned by stripe  
      )
      # 2. build line items on @order
      @order.line_items.new(
        product: @product1,
        quantity: 2,
        item_price: @product1.price,
        total_price: @product1.price * 2
      )
      @order.line_items.new(
        product: @product2,
        quantity: 4,
        item_price: @product2.price,
        total_price: @product2.price * 4
      )
      # 3. save! the order - ie raise an exception if it fails (not expected)
      @order.save!
      # 4. reload products to have their updated quantities
      @product1.reload
      @product2.reload
      # 5. use RSpec expect syntax to assert their new quantity values
      expect(@product1.quantity).to equal(17)
      expect(@product2.quantity).to equal(24)
    end
    # pending test 2
    it 'does not deduct quantity from products that are not in the order' do
      # TODO: Implement based on hints in previous test
      @order = Order.new(
        email: 'kvirani@gmail.com',
        total_cents: 769.06,
        stripe_charge_id: 'ch_1EcLT32eZvKYlo2CGdFlVBQ9', # returned by stripe  
      )
      # 2. build line items on @order
      @order.line_items.new(
        product: @product1,
        quantity: 2,
        item_price: @product1.price,
        total_price: @product1.price * 2
      )
      @order.line_items.new(
        product: @product2,
        quantity: 4,
        item_price: @product2.price,
        total_price: @product2.price * 4
      )
      # 3. save! the order - ie raise an exception if it fails (not expected)
      @order.save!
      # 4. reload products to have their updated quantities
      @product1.reload
      @product2.reload
      # 5. use RSpec expect syntax to assert their new quantity values
      expect(@product3.quantity).to equal(40)
    end
  end
end