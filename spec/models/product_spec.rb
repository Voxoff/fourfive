require 'rails_helper'

RSpec.describe Product, type: :model do
  describe "A User (in general)" do
    subject { Product.new(name: "x") }
    context "setter methods" do
      it "should have this name" do

        expect(subject.name).to eq 'x'
      end
    end
  end
end
