require 'rails_helper'

RSpec.describe Coupon, type: :model do
  coupon = FactoryBot.create(:coupon)
  activated_coupon = FactoryBot.create(:activated_coupon)
  context "Validations" do

    it "is valid with valid attributes" do
      expect(Coupon.new(code: "code", discount: 10)).to be_valid
    end
    it "is not valid without a code" do
      expect { Coupon.new(discount: 10).to raise_error(/upcase/) }
      expect { Coupon.new(discount: 10, active: false).to raise_error(/upcase/) }
    end

    it "is not valid without a discount" do
      expect(Coupon.new(code: "code")).to_not be_valid
      expect(Coupon.new(code: "code", active: false)).to_not be_valid
    end

    it "upcases automatically" do
      expect(coupon.code).to eq "MYCODE"
    end
  end

  context "Calculations" do
    describe "#percent" do
      it "calculates %" do
        expect(coupon.percent).to eq 0.1
      end
    end

    describe "#activate" do
      it "should activate" do
        expect(coupon.active).to eq false
        expect(coupon.activate).to eq true
        expect(coupon.active).to eq true
      end
    end

    describe "#deactivate" do
      it "should deactivate" do
        expect(activated_coupon.active).to eq true
        expect(activated_coupon.deactivate).to eq true
        expect(activated_coupon.active).to eq false
      end
    end
  end
end
