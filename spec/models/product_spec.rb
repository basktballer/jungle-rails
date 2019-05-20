require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do

    before do 
      @category = Category.new
      @product = Product.new( :name => "test name", :price => 200, :quantity => 200, :category => @category)
    end

    it "is valid with valid atrributes" do
      expect(@product).to be_valid
    end
    it "is not valid without a name" do
      @product.name = nil
      @product.valid?
      expect(@product.errors.full_messages).to include("Name can't be blank")
    end
    it "is not valid without a price" do
      @product.price_cents = nil
      @product.valid?
      expect(@product.errors.full_messages).to include("Price can't be blank")
    end
    it "is not valid without a quantity" do
      @product.quantity = nil
      @product.valid?
      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end
    it "is not valid without a category" do
      @product.category = nil
      @product.valid?
      expect(@product.errors.full_messages).to include("Category can't be blank")
    end
  end
end
