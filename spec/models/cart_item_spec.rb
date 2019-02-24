require 'rails_helper'

RSpec.describe CartItem, type: :model do
  cart_item = FactoryBot.create(:cart_item)
  single_capsules_cart_item = FactoryBot.create(:single_capsules_cart_item)
  context "general" do
    describe "#line_cost" do
      it "calculates cost" do
        expect(cart_item.line_cost).to eq Money.new(29990)
        expect(single_capsules_cart_item.line_cost).to eq Money.new(2999)
      end
    end


    describe "#line_cost" do
      it "calculates cost" do
        expect(cart_item.line_cost).to eq Money.new(29990)
      end
    end

    describe "#update_or_destroy" do
      it "destroys self if new quantity is zero or lower" do
        # best i can do for now
        expect { [cart_item.update_or_destroy(-10), cart_item.reload] }.to raise_error ActiveRecord::RecordNotFound
      end

      it "updates self if quantity is > 0" do
        # best i can do for now
        expect(cart_item.update_or_destroy(10)).to eq true
      end
    end
  end
end
