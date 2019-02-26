require 'rails_helper'

RSpec.describe Product, type: :model do
  context "A Product (in general)" do
    balm_product = FactoryBot.create(:balm_product)
    oil_product = FactoryBot.create(:oil_product)
    capsule_product = FactoryBot.create(:capsule_product)

    describe "Getter/setter methods" do
      it "should have name" do
        expect(balm_product.name).to eq 'cbd_balms'
      end
    end

    describe "#readablename" do
      it 'changes name' do
        expect(balm_product.readable_name).to eq "cbd balms"
      end
    end

    describe "#oils?" do
      it "checks if product is an oil" do
        expect(balm_product.oil?).to eq false
        expect(oil_product.oil?).to eq true
      end
    end

    describe "#balms?" do
      it "checks if product is an balm" do
        expect(balm_product.balm?).to eq true
        expect(oil_product.balm?).to eq false
      end
    end

    describe "#capsules?" do
      it "checks if product is an capsules" do
        expect(oil_product.capsules?).to eq false
        expect(capsule_product.capsules?).to eq true
      end
    end

    describe "#specific_name" do
      it "returns detailed product name" do
        expect(balm_product.specific_name).to eq "Small balm"
        expect(oil_product.specific_name).to eq "Natural 500mg oil"
        expect(capsule_product.specific_name).to eq "Capsules"
      end
    end

    describe "#revenue" do
      it "calcs revenue" do
        expect(oil_product.revenue(2)).to eq Money.new(5998)
        expect(capsule_product.revenue(5)).to eq Money.new(19995)
      end
    end
  end
end
