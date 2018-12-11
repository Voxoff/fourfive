require 'rails_helper'

RSpec.describe Cart, type: :model do
  context "validation tests" do
    it "may have a user" do
      cart = Cart.new()
      expect(cart).to eq(true)
    end
  end

  context "#amount" do
    subject { Cart.new }
    it "cals amount" do
      expect(subject.amount).to eql()
    end
  end
end
