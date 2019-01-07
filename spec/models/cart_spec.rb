require 'rails_helper'

RSpec.describe Cart, type: :model do
  cart = FactoryBot.create(:cart)
  # cart_item = FactoryBot.create(:cart_item)

  context "associations tests" do
    it "may have no user" do
      expect(cart).to be_an_instance_of Cart
    end
  end

  context "#amount" do
   it "calls amount" do
    #errors because of the includes in cart.rb eh?
      expect(cart.amount).to eql(59.98)
    end
  end
end
