require 'rails_helper'

RSpec.describe Product, type: :model do
  context "A User (in general)" do
    product = FactoryBot.create(:product)

    describe "Getter/setter methods" do
      it "should have name" do
        expect(product.name).to eq 'cbd_balms'
      end
    end

    describe "#readablename" do
      it 'changes name' do
        expect(product.readable_name).to eq "cbd balms"
      end
    end
  end
end
