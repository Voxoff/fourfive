require 'rails_helper'

RSpec.describe CartItem, type: :model do
  context "general" do
    let(:cart_item) { FactoryBot.create(:cart_item)}
    p CartItem.count
    single_capsules_cart_item = FactoryBot.build(:single_capsules_cart_item)
    describe "validations" do
      it "is valid" do

        expect(cart_item).to be_valid
      end
    end
    describe "#line_cost" do
      it "calculates cost" do
        expect(single_capsules_cart_item.line_cost).to eq Money.new(2999)
      end

      it "calculates cost" do
        expect(cart_item.line_cost).to eq Money.new(29_990)
      end
    end

    # describe "#update_or_destroy" do
    #   it "destroys self if new quantity is zero or lower" do
    #     # best i can do for now
    #     cart_item.update_or_destroy(-8)
    #     expect(cart_item.quantity).to eq 12
    #   end

    #   it "destroys" do
    #     expect { cart_item.destroy }.to change(CartItem, :count).by(-1)
    #   end

    #   it "updates self if quantity is > 0" do
    #     expect(cart_item.update_or_destroy(10)).to eq true
    #   end
    # end
  end
end
