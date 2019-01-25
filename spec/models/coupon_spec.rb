require 'rails_helper'

RSpec.describe Coupon, type: :model do
  it "is valid with valid attributes" do
    expect(Coupon.new(code: "code", discount: 10)).to be_valid
  end
  it "is not valid without a code" do
    expect(Coupon.new(discount: 10)).to_not be_valid
    expect(Coupon.new(discount: 10, active: false)).to_not be_valid
  end
  it "is not valid without a discount" do
    expect(Coupon.new(code: "code")).to_not be_valid
    expect(Coupon.new(code: "code", active: false)).to_not be_valid
  end
  it "is not valid without a start_date" do

  end
end
